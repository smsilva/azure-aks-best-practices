# AKS Best Practices Sandbox

Este repositório tenta implementar as práticas recomendas pela Microsoft para Clusters AKS usando Terraform.

O código Terraform aqui listado é fruto da minha jornada pessoal de aprendizado e não deve ser usado em ambientes de produção.

Referências: https://docs.microsoft.com/en-us/azure/aks/best-practices

## Como usar este repositório

Para usar este repositório você vai precisar instalar o Terraform e eu recomendo que você siga as instruções no site oficial da Hashicorp.

Se você estiver usando o Ubuntu 20.04 como eu, talvez queira seguir os passos abaixo.

### Terraform

```shell
wget https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip

unzip terraform_1.0.1_linux_amd64.zip

rm terraform_1.0.1_linux_amd64.zip

chmod +x terraform

mkdir -p ${HOME?}/bin

mv terraform ${HOME?}/bin/terraform

terraform -version
```

Após executar o último comando, você deverá ver a versão do Terraform instalada:

```shell
Terraform v1.0.2
on linux_amd64
```

### Clonando o Repositório

```shell
git clone https://github.com/smsilva/azure-aks-best-practices.git

cd azure-aks-best-practices
```

### Configurando variaveis de ambiente para acesso a Azure

Você precisará criar:

- Service Principal na Azure para usá-la com o Terraform.
- Resource Group (usei um com nome de "iac")
- Storage Account (use uma com o nome de "silvios")
- Container (Na Storage Account, criei um container chamado "terraform")

```shell
export ARM_CLIENT_ID="COLOQUE_AQUI_O_CODIGO_DA_SUA_SERVICE_PRINCIPAL"
export ARM_TENANT_ID="COLOQUE_AQUI_O_CODIGO_DO_TENANT_DA_SUA_CONTA"
export ARM_CLIENT_SECRET="COLOQUE_AQUI_A_CLIENT_SECRET"
export ARM_SUBSCRIPTION_ID="ID_DA_SUA_AZURE_SUBSCRIPTION"
export ARM_ACCESS_KEY="ACCESS_KEY_GERADA_NA_CRIACAO_DA_STORAGE_ACCOUNT"
```

### Testando

```shell
cd azure-aks-best-practices/src

terraform init
terraform plan
```
