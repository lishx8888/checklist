FROM python:3.9-alpine AS builder

WORKDIR /app

# 只复制必要的文件
COPY m3ucheck.py /app/

# 安装依赖
RUN pip install --no-cache-dir --target=/app/vendor aiohttp numpy

FROM python:3.9-alpine

WORKDIR /app

# 只复制必要的文件和依赖
COPY --from=builder /app/vendor /app/vendor
COPY m3ucheck.py /app/

ENV PYTHONPATH=/app/vendor

CMD ["python", "m3ucheck.py"]