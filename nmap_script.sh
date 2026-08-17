#!/usr/bin/env bash

options() {
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  BOLD='\033[1m'
  NC='\033[0m'

  target_menu="
                       ${GREEN}${BOLD}NMAP${NC} ${RED}v.01${NC}
  [1] SYN-сканирование         [6] Определение версий служб
  [2] TCP-сканирование         [7] Определение ОС
  [3] UDP-сканирование         [8] Агрессивное сканирование
  [4] FIN-сканирование         [9] Быстрое сканирование 100 портов
  [5] ACK-сканирование         [10] Все порты (65535-портов)

                    ${RED}[0] Quit-Завершает программу${NC}
  "

  echo -e "$target_menu"
  read -p $'\033[0;32m[+] Введите опцию сканирования: \033[0m' show_options

  # Проверка на выход
  if [[ "$show_options" == "0" || "$show_options" == "Quit" ]]; then
    echo -e "${RED}Программа завершена${NC}"
    exit 0
  fi

  # Проверка, что введено число от 1 до 10
  if [[ "$show_options" =~ ^[1-9]$|^10$ ]]; then
    read -p $'\033[0;32m[+] Введите ip адрес: \033[0m' ip_addres_target

    if [[ -z "$ip_addres_target" ]]; then
      echo -e "${RED}❌ IP-адрес не может быть пустым!${NC}"
      exit 1
    fi

    echo -e "${GREEN}✅ Запускаю сканирование...${NC}"
    echo ""

    case "$show_options" in
      1) nmap -sS "$ip_addres_target" ;;
      2) nmap -sT "$ip_addres_target" ;;
      3) nmap -sU "$ip_addres_target" ;;
      4) nmap -sF "$ip_addres_target" ;;
      5) nmap -sA "$ip_addres_target" ;;
      6) nmap -sV "$ip_addres_target" ;;
      7) nmap -O "$ip_addres_target" ;;
      8) nmap -A "$ip_addres_target" ;;
      9) nmap -F "$ip_addres_target" ;;
      10) nmap -p- "$ip_addres_target" ;;
      *) echo -e "${RED}❌ Неверный выбор!${NC}" ;;
    esac
  else
    echo -e "${RED}❌ Неверный ввод!${NC}"
    echo -e "${RED}Программа завершена${NC}"
    exit 0
  fi
}

options
