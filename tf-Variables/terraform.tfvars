aws_instance_type = "t2.micro"
ec2_config =  {
    v_size = 20
    v_type = "gp3"
}

additional_tags = {
  DEPT = "QA"
  Project = "Awsome"
}