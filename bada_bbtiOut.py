import os
from matplotlib import pyplot as plt
import oracledb
import pandas as pd

# 한글 폰트 설정
plt.rcParams['font.family'] = 'DOSGothic'
plt.rcParams['font.sans-serif'] = ['https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_eight@1.0/DOSGothic.woff']
plt.rcParams.update({'font.size': 18})  # 글꼴 크기를 14로 설정

# 클라이언트 오라클 초기화
oracledb.init_oracle_client(lib_dir="C:\\ezentools\\instantclient_11_2")

# 데이터베이스 연결
connect = oracledb.connect(user='ezen', password='12345', dsn='localhost')
c = connect.cursor()  # 쿼리문을 담아두는 환경 변수 c

# SQL 쿼리
query = (
    "SELECT bada_bbti.bbti_name as bbti, COUNT(bada_user.bbti) AS count "
    "FROM bada_bbti "
    "LEFT JOIN bada_user ON bada_user.bbti = bada_bbti.bbti_code "
    "GROUP BY bada_bbti.bbti_name"
)

# 쿼리 실행
c.execute(query)
data = c.fetchall()

# 데이터프레임 생성
df = pd.DataFrame(data, columns=['bbti', 'count'])

# 원 그래프 그리기
fig, ax = plt.subplots(figsize=(8, 8))

# 색상 설정
colors = ['#7fc97f', '#beaed4', '#fdc086', '#ffff99',
          '#386cb0', '#f0027f', '#bf5b17', '#666666']

# 파이 차트 그리기
ax.pie(df['count'], labels=df['bbti'], autopct='%1.1f%%', startangle=140, colors=colors)

# 원 그래프 중심에 동그라미를 그려서 원 그래프를 원으로 보이게 함
ax.axis('equal')

# 절대 경로로 저장 경로 설정 (유니코드 문자열 사용)
output_dir = r'C:\이젠디지탈12\spring\bada\src\main\webapp\resources\image'
output_path = os.path.join(output_dir, 'graph_image.png')

# 그래프를 파일로 저장
plt.savefig(output_path)

# 그래프 닫기
plt.close()
