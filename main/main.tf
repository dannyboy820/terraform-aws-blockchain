provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../mgmt/vpc"
}

/**
* QUIRK
* if you change the name_prefix, you would need to modify the task def
* to reflect the change. e.g. modify name_prefix to quidax-demo
* then nginx.json name would be quidax-demo-setup
*/
module "bastion" {
  source           = "../modules/bastion"
  vpc_id           = "${module.vpc.vpc_id}"
  public_subnet_id = "${module.vpc.public_subnet_id}"
  ssh_key_pair     = "${aws_key_pair.ssh_keypair.key_name}"
}

module "ethereum" {
  source               = "../modules/blockchain"
  vpc_id               = "${module.vpc.vpc_id}"
  name_prefix          = "ethereum"
  public_subnets       = "${module.vpc.public_subnet_id},${module.vpc.public_subnet_id_2}"
  private_subnets      = "${module.vpc.private_subnet_id},${module.vpc.private_subnet_id_2}"
  instance_sg          = "${aws_security_group.ethereum_security_group.id}"
  container_definition = "${file("./task-definitions/ethereum.json")}"
  container_port       = "8545"
  ssh_key_pair         = "${aws_key_pair.ssh_keypair.key_name}"
}

module "bitcoin" {
  source               = "../modules/blockchain"
  vpc_id               = "${module.vpc.vpc_id}"
  name_prefix          = "bitcoin"
  public_subnets       = "${module.vpc.public_subnet_id},${module.vpc.public_subnet_id_2}"
  private_subnets      = "${module.vpc.private_subnet_id},${module.vpc.private_subnet_id_2}"
  instance_sg          = "${aws_security_group.bitcoin_security_group.id}"
  container_definition = "${file("./task-definitions/bitcoin.json")}"
  container_port       = "8332"
  volume_size          = "300"
  ssh_key_pair         = "${aws_key_pair.ssh_keypair.key_name}"
}

module "ripple" {
  source               = "../modules/blockchain"
  vpc_id               = "${module.vpc.vpc_id}"
  name_prefix          = "ripple"
  private_subnets      = "${module.vpc.public_subnet_id},${module.vpc.public_subnet_id_2}"
  public_subnets       = "${module.vpc.private_subnet_id},${module.vpc.private_subnet_id_2}"
  instance_sg          = "${aws_security_group.ripple_security_group.id}"
  instance_type        = "m5.2xlarge"
  container_definition = "${file("./task-definitions/ripple.json")}"
  container_port       = "51235"
  volume_size          = "300"
  ssh_key_pair         = "${aws_key_pair.ssh_keypair.key_name}"
}


module "bitcoin_cash" {
  source               = "../modules/blockchain"
  vpc_id               = "${module.vpc.vpc_id}"
  name_prefix          = "bitcoin-cash"
  private_subnets      = "${module.vpc.public_subnet_id},${module.vpc.public_subnet_id_2}"
  public_subnets       = "${module.vpc.private_subnet_id},${module.vpc.private_subnet_id_2}"
  instance_sg          = "${aws_security_group.bitcoin_security_group.id}"
  container_definition = "${file("./task-definitions/bitcoin_cash.json")}"
  container_port       = "8332"
  volume_size          = "300"
  ssh_key_pair         = "${aws_key_pair.ssh_keypair.key_name}"
}


module "bitcoin_gold" {
  source               = "../modules/blockchain"
  vpc_id               = "${module.vpc.vpc_id}"
  name_prefix          = "bitcoin-gold"
  private_subnets      = "${module.vpc.public_subnet_id},${module.vpc.public_subnet_id_2}"
  public_subnets       = "${module.vpc.private_subnet_id},${module.vpc.private_subnet_id_2}"
  instance_sg          = "${aws_security_group.bitcoin_security_group.id}"
  container_definition = "${file("./task-definitions/bitcoin_gold.json")}"
  container_port       = "8332"
  volume_size          = "300"
  ssh_key_pair         = "${aws_key_pair.ssh_keypair.key_name}"
}

