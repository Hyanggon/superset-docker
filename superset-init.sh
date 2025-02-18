#!/bin/bash

# DB 실행
echo "Starting db & redis services..."
docker compose up db redis -d

# Superset 실행
docker compose up superset -d 
echo "Superset 및 관련 서비스가 시작되었습니다."

# 최대 시도 횟수 설정
MAX_RETRIES=5
COUNT=0

until docker-compose exec superset superset db upgrade || [ $COUNT -eq $MAX_RETRIES ]; do
  echo "Superset이 준비될 때까지 대기 중... (시도: $((COUNT+1))/$MAX_RETRIES)"
  sleep 5
  COUNT=$((COUNT+1))
done

if [ $COUNT -eq $MAX_RETRIES ]; then
  echo "최대 시도 횟수를 초과했습니다. 스크립트를 종료합니다."
  exit 1
fi

echo "데이터베이스 마이그레이션 완료."

# 관리자 계정 생성
docker-compose exec superset superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@example.com \
  --password admin

echo "관리자 계정 생성 완료."


# 예제 데이터 로드 (선택 사항)
# docker-compose exec superset superset load_examples
# echo "예제 데이터 로드 완료."

# Superset 초기화
docker-compose exec superset superset init

echo "Superset 초기화 완료. http://localhost:8088 에서 접속 가능합니다."

# RETURN 키 입력 대기
read -p "RETURN 키를 누르면 종료 및 docker compose down 수행" 

echo "docker compose 종료 중..."
docker compose down
echo "모든 서비스가 종료되었습니다."