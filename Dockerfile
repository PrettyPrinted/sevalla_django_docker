FROM python:latest  

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 
 
RUN mkdir /app
WORKDIR /app
 
RUN pip install --upgrade pip 
COPY requirements.txt  .
RUN pip install --no-cache-dir -r requirements.txt
 
COPY . .

RUN SECRET_KEY=dummy DATABASE_URL=sqlite:///db.sqlite3 python3 manage.py collectstatic --no-input
 
CMD ["gunicorn", "example.wsgi"]