from matplotlib import pyplot as plt
import oracledb
import pandas as pd

# 한글 폰트 설정
plt.rcParams['font.family'] = 'Malgun Gothic'
plt.rcParams['axes.unicode_minus'] = False

# 클라이언트 오라클 초기화
oracledb.init_oracle_client(lib_dir="C:\\ezen\\python\\oracle\\instantclient_11_2")

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

# 막대 그래프 및 산점도 그리기
fig, ax = plt.subplots(figsize=(18, 5))

colors = ['#7fc97f', '#beaed4', '#fdc086', '#ffff99',
          '#386cb0', '#f0027f', '#bf5b17', '#666666']

# 막대 그래프 그리기
ax.bar(df['bbti'], df['count'], color=colors, label=df['bbti'])

# 산점도 그리기
ax.scatter(df['bbti'], df['count'], color="gray")

# 범례 위치 조정
ax.legend(bbox_to_anchor=(1, 1.1))

# 그래프를 왼쪽으로 이동
plt.subplots_adjust(left=0.05)

# 축 레이블 및 타이틀 설정
ax.set_xlabel('BBTI') 
ax.set_ylabel('인원 수', rotation=0, labelpad=20)
ax.set_title('바라는 바다 사용자의 BBTI 비율')

# 그래프 표시
plt.show()
