# Big_Contest_2017
2017 빅콘테스트 퓨처스리그 개봉 전 영화 관람객 수 예측

## 1. 제안기법
![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/1.1.%EC%A0%9C%EC%95%88%EA%B8%B0%EB%B2%95.png)

## 2. 실험 설계
![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/1.2.%EC%8B%A4%ED%97%98%EC%84%A4%EA%B3%84.png)

## 3. 설명 변수
**1. 기본설명 변수 & 새로운 변수**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/2.%EA%B8%B0%EB%B3%B8%EC%84%A4%EB%AA%85%EB%B3%80%EC%88%98.png)

**2. 구전효과를 나타내는 새로운 변수**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/3.%EC%84%A4%EB%AA%85%EB%B3%80%EC%88%98(positive).png)

**3. 경쟁효과를 나타내는 새로운 변수**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/4.%EC%84%A4%EB%AA%85%EB%B3%80%EC%88%98(comp_1%2Ccomp_2%2Ccom_3).png)

## 4. 데이터의 선형성 여부 확인

**잔차 그래프**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/5.%EC%9E%94%EC%B0%A8%EA%B7%B8%EB%9E%98%ED%94%84.png)

잔차 그래프의 패턴을 통해서 데이터가 선형성을 띄지 않음을 확인

## 5. Box_Cox 변환

**5.1 Box_Cox 변환 후, 선형 회귀**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/6.Box-cox%20%EB%B3%80%ED%99%98.png)

**5.2 Box_Cox 변환 후, 잔차 그래프**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/7.box_cox%ED%9B%84%20%EC%9E%94%EC%B0%A8%EA%B7%B8%EB%9E%98%ED%94%84.png)

잔차 그래프의 패턴을 통해서 데이터의 선형성을 확인

**5.3 Box_Cox 변환 후, 모델 성능**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/8.box_cox%ED%9B%84%20%EC%84%A0%ED%98%95%ED%9A%8C%EA%B7%80%20%EA%B2%B0%EA%B3%BC.png)

## 6.비선형 모델

**6.1 유전알고리즘을 이용한 설명변수 선택**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/9.%EB%B9%84%EC%84%A0%ED%98%95-GA%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20%EC%84%A4%EB%AA%85%EB%B3%80%EC%88%98%20%EC%84%A0%ED%83%9D.png)

**6.2 비선형 모델 성능**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/10.비선형%20모델평가.png)

1. 킹스맨의 경우 14일, 남한산성과 넛잡2의 경우 8일의 누적 관객수를 구해야 됨.
2. 따라서 각 영화에 대해서 모델을 만듦.
3. 최종적으로 10 fold Cross-validation을 통해 세 가지 모델에 대해서 성능을 비교해본 결과, Random Forest의 성능이 가장 뛰어남을 알 수 있었음.

**6.3 킹스맨/남한산성/넛잡2의 스크린 수 예측**

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/11.(%EB%82%98%EC%A4%91%EC%97%90%20%EC%B6%94%EA%B0%80%ED%96%88%EB%8D%98%20%EC%98%81%ED%96%A5%EB%A0%A5%EC%9D%B4%20%EB%A7%A4%EC%9A%B0%20%EC%BB%B8%EB%8D%98%20%EC%84%A4%EB%AA%85%EB%B3%80%EC%88%98)%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%88%98%20%EC%98%88%EC%B8%A1.png)

## 7. 최종 예측 결과

![alt_text](https://github.com/Juhee-Maeng/Big_Contest_2017/blob/master/images/12.%EC%B5%9C%EC%A2%85%EA%B2%B0%EA%B3%BC.png)
