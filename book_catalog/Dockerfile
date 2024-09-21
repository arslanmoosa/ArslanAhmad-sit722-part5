# Your Solution
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
COPY ./app .
RUN pip install -r ./requirements.txt
#ENV DATABASE_URL=postgresql://arslan_moosa_db_7_2_part4_user:W6kze7sSHnLOe4lyZgw0z2VAPJG1rynd@dpg-crmtmr56l47c73fu9i6g-a.oregon-postgres.render.com/arslan_moosa_db_7_2_part4
CMD uvicorn main:app --host 0.0.0.0 --port $PORT