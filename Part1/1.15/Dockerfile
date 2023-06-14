FROM python:3.9-slim

WORKDIR /app


EXPOSE 8080


COPY calculator.py /app


RUN pip install --no-cache-dir flask



CMD [ "python", "calculator.py" ]

