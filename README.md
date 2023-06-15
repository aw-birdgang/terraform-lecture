<!--  -->
<!--
-->

# brew tfenv 설치
````
$ brew install tfenv

````

# tfenv terraform 설치 및 버전 관리
````
# 설치 가능한 저번 목록 확인
$ tfenv list-remote
1.5.0-beta2
1.5.0-beta1
1.5.0-alpha20230504
1.5.0-alpha20230405
1.4.6
1.4.5
1.4.4
1.4.3
.
.

# 특정 버전 설치
$ tfenv install 1.4.6

# 최신 버전 설치
$ tfenv install latest

# 테라폼 파일 분석후 최소 요구 버전 설치
$ tfenv install min-required

# .terraform-version에 지정된 버전 설치
$ terraform install

````


# tfenv 사용
````
$ tfenv list

# 특정 버전 사용
$ tfenv use 1.4.6

# 최신 버전 사용
$ tfenv use latest

````


# init
````
https://developer.hashicorp.com/terraform/cli/run

$ terraform init
$ terraform plan
$ terraform apply
$ terraform destroy

````
