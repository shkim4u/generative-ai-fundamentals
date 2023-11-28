# Trnasformer with TensorFlow Workshop
> (참고)<br>
> 이 워크샵은 GPU가 갖추어지지 않은 일반적인 리눅스 인스턴스 (예: c5.9xlarge)에서도 수행해 볼 수 있도록 구성되었습니다.


## Agenda
1. Cloud9 통합 환경 (IDE) 생성 (CloudShell 사용)
2. Cloud9 통합 환경 (IDE) 설정 (Cloud9)
3. Transformer with TensorFlow Demo Kit 받기
4. Transformer 학습 및 추론 실습 (Jupyter Notebook)

## 1. Cloud9 통합 환경 (IDE) 생성 (CloudShell 사용)
### 1.1. AWS Cloud9 환경 생성 (AWS CLI 사용)
진행자가 제공한 AWS 관리 콘솔에서 ```CloudShell```을 실행한 후 아래 명령을 수행하여 ```Cloud9``` 환경을 생성해 줍니다.<br>
```CloudShell```도 다수의 개발 언어와 런타임, 그리고 클라우드 환경을 다룰 수 있는 CLI를 기본적으로 제공하지만 컨테이너를 사용할 수 있고 풍부한 통합 개발 환경을 제공하는 ```Cloud9```을 사용하기로 합니다.<br>
```bash
curl -fsSL https://raw.githubusercontent.com/shkim4u/Generative-AI-Fundamentals/main/cloud9/bootstrap-v2-with-admin-user-trust.sh | bash
```
## 2. Cloud9 통합 개발 환경 (IDE) 설정
```Cloud9``` 통합 환경에 접속하여 필요한 사항을 사전에 구성한 쉘 스크립트 파일을 아래와 같이 실행합니다.

여기에는 다음 사항이 포함됩니다.
1. IDE IAM 설정 확인
2. 쿠버네테스 (Amazon EKS) 작업을 위한 Tooling
    * kubectl 설치
    * eksctl 설치
    * k9s 설치
    * Helm 설치
3. AWS CLI 업데이트
4. AWS CDK 업그레이드
5. 기타 도구 설치 및 구성
    * AWS SSM 세션 매니저 플러그인 설치
    * AWS Cloud9 CLI 설치
    * jq 설치하기
    * yq 설치하기
    * bash-completion 설치하기
6. Cloud9 추가 설정하기
7. 디스크 증설
8. CUDA Deep Neural Network (cuDNN) 라이브러리

```bash
cd ~/environment/
curl -fsSL https://raw.githubusercontent.com/shkim4u/Generative-AI-Fundamentals/main/cloud9/cloud9.sh | bash
```


Download below cuDNN library from NVIDIA Developer site.
https://developer.nvidia.com/downloads/compute/cudnn/secure/8.9.6/local_installers/12.x/cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz/


https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#installdriver

아래 경로에 이미 다운로드되어 있음
aws s3 presign "s3://shkim4u-dev-backup/cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz"
wget <Presigned URL> -o cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz
tar -xvf cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz
; No need: sudo yum install zlib

sudo mkdir -p /usr/local/cuda/include /usr/local/cuda/lib64

sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*


And then upload it to the Cloud9.

sudo yum remove -y openssl-devel
sudo yum install -y openssl11 openssl11-devel

pip uninstall urllib3
pip install 'urllib3<2.0'

python3 -m venv .venv
source .venv/bin/activate
pip install jupyterlab

jupyter lab --ip 0.0.0.0

Open port 8888 for the EC2 instance of Cloud9.

브라우저로 EC2 주소 http://<EC2 주소>:8888로 접속

Cloud9에서 표시되는 토큰을 사용하여 로그인

transforme.ipynb Setup 섹션에서 아래 줄은 주석 처리
#!apt install --allow-change-held-packages libcudnn8=8.1.0.77-1+cuda11.2
