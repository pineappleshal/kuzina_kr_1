#!/bin/bash
set -euo pipefail

echo "=== 1) Создание testfile.sh ==="
cat > testfile.sh <<'EOF'
#!/bin/bash
# Простой тестовый скрипт
echo "Это testfile.sh — проверочный скрипт"
EOF

echo
echo "=== 2) Список файлов (длинный список) в текущем каталоге ==="
ls -la

echo
echo "=== 3) Системная информация и версия выпуска ядра ==="
echo "--- uname -a ---"
uname -a || true
echo
echo "--- uname -r (версия ядра) ---"
uname -r || true

if [ -f /etc/os-release ]; then
  echo
  echo "--- /etc/os-release ---"
  cat /etc/os-release
fi

echo
echo "=== 4) Переход в каталог tasks/templates ==="
if cd tasks/templates 2>/dev/null; then
  echo "Успешно перешли в: $(pwd)"
else
  echo "Каталог tasks/templates не найден — остаюсь в: $(pwd)"
fi

echo
echo "=== 5) Имя текущего пользователя, вошедшего в терминал ==="
if command -v logname >/dev/null 2>&1; then
  logname 2>/dev/null || whoami
else
  whoami
fi

echo
echo "=== 6) Сохранение главной страницы Финансового университета в файл 'kuzina.txt' ==="
URL="https://www.fa.ru/"
OUT="kuzina.txt"

if command -v curl >/dev/null 2>&1; then
  if curl -sSL "$URL" -o "$OUT"; then
    echo "Главная страница сохранена в $OUT (через curl)."
  else
    echo "Не удалось скачать страницу через curl."
  fi
elif command -v wget >/dev/null 2>&1; then
  if wget -qO "$OUT" "$URL"; then
    echo "Главная страница сохранена в $OUT (через wget)."
  else
    echo "Не удалось скачать страницу через wget."
  fi
else
  echo "Ни curl, ни wget не найдены — не могу скачать $URL."
fi

echo
echo "=== Скрипт завершил работу ==="