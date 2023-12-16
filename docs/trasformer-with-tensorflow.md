# Trnasformer with TensorFlow Workshop
> (참고)<br>
> 이 워크샵은 GPU가 갖추어지지 않은 일반적인 리눅스 인스턴스 (예: c5.9xlarge)에서도 수행해 볼 수 있도록 구성되었습니다.


## Agenda
1. Cloud9 통합 환경 (IDE) 생성 (CloudShell 사용)
2. Cloud9 통합 환경 (IDE) 설정 (Cloud9)
3. Transformer with TensorFlow Demo Kit 받기
4. Jupyter Notebook 환경 구성
5. Transformer 학습 및 추론 실습 (Jupyter Notebook)

## 1. Cloud9 통합 환경 (IDE) 생성 (CloudShell 사용)
### 1.1. AWS Cloud9 환경 생성 (AWS CLI 사용)
진행자가 제공한 AWS 관리 콘솔에서 ```CloudShell```을 실행한 후 아래 명령을 수행하여 ```Cloud9``` 환경을 생성해 줍니다.<br>
```CloudShell```도 다수의 개발 언어와 런타임, 그리고 클라우드 환경을 다룰 수 있는 CLI를 기본적으로 제공하지만 컨테이너를 사용할 수 있고 풍부한 통합 개발 환경을 제공하는 ```Cloud9```을 사용하기로 합니다.<br>
```bash
curl -fsSL https://raw.githubusercontent.com/shkim4u/Generative-AI-Fundamentals/main/cloud9/bootstrap-v2-with-admin-user-trust.sh | bash -s -- c5.9xlarge
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
9. [2023-12-06 추가] Terraform 라이선스 정책 변경으로 인해 Cloud9에서 Terraform이 제거됨으로써 수동 설치

```bash
cd ~/environment/
curl -fsSL https://raw.githubusercontent.com/shkim4u/Generative-AI-Fundamentals/main/cloud9/cloud9.sh | bash
```

## 3. Transformer with TensorFlow Demo Kit 받기
```bash
cd ~/environment/
git clone https://github.com/shkim4u/Generative-AI-Fundamentals.git generative-ai-fundamentals
cd generative-ai-fundamentals

# No need to track git.
rm -rf .git
```

## 4. Jupyter Notebook 환경 구성

해당 리포지터리에는 Foundation Model에 활용되는 Transformer를 TensorFlow를 통해 이해할 있도록 도와주는 Jupyter Notebook 파일이 포함되어 있습니다.<br>

Cloud9 상에서 Jupyter Notebook 환경을 구성하기 위하여 아래 명령을 수행합니다.

```bash
cd ~/environment/generative-ai-fundamentals

python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip

# Upgrade OpenSSL to 1.1 compatible with urllib3 v2.0.
#sudo yum remove -y openssl-devel
#sudo yum install -y gcc openssl11-devel bzip2-devel libffi-devel 

# In case the above not working.
# It's tricky a little bit to migrate to urllib3 version 2, which requires Amazon Linux 2023 and Python upgrade; Let's take a quick workaround for now.
# Amazon Linux 2: Upgrade to Amazon Linux 2023. Alternatively, you can install OpenSSL 1.1.1 on Amazon Linux 2 using yum install openssl11 openssl11-devel and then install Python with a tool like pyenv.
# https://urllib3.readthedocs.io/en/2.0.6/v2-migration-guide.html 
pip uninstall -y urllib3
pip install 'urllib3<2.0'

pip install jupyterlab

nohup jupyter lab --ip 0.0.0.0 &
tail -f nohup.out
```

위를 수행하면 표시되는 URL에 표시되는 인증 토큰을 메모해 두고 Jupyter Notebook 접속할 때 사용합니다.<br>
Jupyter Notebook 접속 주소는 아래 명령을 통해 얻을 수 있습니다.<br>
```bash
# export EC2_INSTANCE_ID=$(aws ec2 describe-instances --filters Name=tag:Name,Values="*cloud9-workspace*" Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].InstanceId" --output text)
export EC2_INSTANCE_ID=$(aws ec2 describe-instances --filters Name=tag:Name,Values="*DLAMI-Instance*" Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].InstanceId" --output text)

# Retrieve the public IP address of EC2 instance with AWS CLI.
export EC2_INSTANCE_IP=$(aws ec2 describe-instances --instance-ids $EC2_INSTANCE_ID --query "Reservations[*].Instances[*].PublicIpAddress" --output text)

echo "http://$EC2_INSTANCE_IP:8888"
```

## 5. Transformer 학습 및 추론 실습 (Jupyter Notebook)
이후 과정은 Jupyter Notebook에 접속한 후에 진행자의 안내에 따라 수행합니다.
