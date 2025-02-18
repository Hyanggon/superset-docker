import os

# Redis Cache
CACHE_CONFIG = {
    'CACHE_TYPE': 'redis',
    'CACHE_DEFAULT_TIMEOUT': 300,
    'CACHE_KEY_PREFIX': 'superset_',
    'CACHE_REDIS_HOST': 'redis',
    'CACHE_REDIS_PORT': 6379,
    'CACHE_REDIS_DB': 1,
}

# CORS
ENABLE_CORS = True
CORS_OPTIONS = {
    'supports_credentials': True,
    'allow_headers': ['*'],
    'origins': ['*'],
    'methods': ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS']
}

# Flask-WTF CSRF 설정
WTF_CSRF_ENABLED = False # 개발 환경에서만 False, 운영 환경은 True
WTF_CSRF_EXEMPT_LIST = []
WTF_CSRF_TIME_LIMIT = 60 * 60 * 24 * 365

# SECRET KEY
SECRET_KEY = 'ThisIsAsecretKey'

# PostgreSQL 연결 URI 설정
SQLALCHEMY_DATABASE_URI = 'postgresql+psycopg2://superset:superset@db:5432/superset'

# 추가 보안 옵션
SQLALCHEMY_TRACK_MODIFICATIONS = True

# 사용자 관련 설정
AUTH_USER_REGISTRATION = True  
AUTH_USER_REGISTRATION_ROLE = "Public"  

# Enable file uploads
UPLOAD_FOLDER = os.path.expanduser("./superset_uploads")  
ALLOWED_EXTENSIONS = {'csv', 'parquet'}

# Feature flags to explicitly enable file uploads
FEATURE_FLAGS = {
    "ENABLE_FILE_UPLOADS": True,
    "ENABLE_TEMPLATE_PROCESSING": True, 
    "ALLOW_FILE_UPLOAD_IN_EDITOR": True, 
    "DASHBOARD_NATIVE_FILTERS": True, 
    "ALLOWED_FILE_EXTENSIONS": ["csv", "parquet"] 
}

CSV_DEFAULT_ENCODING = "utf-8"
UPLOAD_EXTENSIONS = ['.csv', '.parquet']
