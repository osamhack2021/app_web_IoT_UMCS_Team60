## AWS cloud 구성을 증명하기 위한 파일
### aws 보안구성 및 CI/CD 파이프라인 등 확인 가능

- cloud 구성은 manual 이나 콘솔로 이루어졌습니다.
- 하지만 이러한 작업 과정은 네트워크나 개발 지식이 필요하나 코드로 나타나지 않습니다.
- 따라서 이러한 과정을 증명하기위해 cloudformation 구성 코드로 export하여 yaml 파일로 나타냈습니다.
- IAM, policy, token, secret, ID 등 보안에 위협이 될 수 있는 내용은 삭제된 내용입니다.
- WAF, webACL, private subnet, security group, route53, deploy, pipline, webhook 등등의 aws cloud  내용을 파일에서 확인 가능
- 코드의 일부를 cloudformation의 stack을 구성하기 위한 **오픈소스코드로 활용**할 수 있다.
## AWS cloud 구성도

![image](https://user-images.githubusercontent.com/28801695/138003676-eeb6cd7f-0be3-4abf-ad89-45880bdd0078.png)
