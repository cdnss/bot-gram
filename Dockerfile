FROM python:3.10-slim

# Update dan install dependency sistem yang diperlukan
RUN apt-get update -y && apt-get install -y \
    ffmpeg \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxcomposite1 \
    libxrandr2 \
    libxdamage1 \
    libxkbcommon0 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxtst6 \
    libglu1-mesa \
    wget \
    && apt-get clean

WORKDIR .

# Copy semua file dari direktori lokal ke dalam container
COPY . .

# Install dependensi Python termasuk Playwright
RUN pip3 install -r requirements.txt
RUN pip3 install playwright

# Install browser Chromium untuk Playwright
RUN python -m playwright install chromium

# Tambahkan izin eksekusi untuk start.sh
RUN chmod +x start.sh

# Jalankan start.sh sebagai entrypoint
CMD ["./start.sh"]

# Port yang akan diekspos
EXPOSE 8080
