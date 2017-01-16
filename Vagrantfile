# -*- mode: ruby -*-
# vi: set ft=ruby :
#

aws_config = (JSON.parse(File.read("aws-infra.json")))

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
  
    aws_config['instances'].each do |instance|
        instance_key   = instance[0]
        instance_value = instance[1]
 
     config.vm.define instance_key do |config2|
	    ec2_tags = instance_value['tags']
  
     config2.vm.provider :aws do |aws, override|
      aws.access_key_id = ENV['AWS_KEY']
      aws.secret_access_key = ENV['AWS_SECRET']
      aws.keypair_name = ENV['AWS_KEYNAME']
      
      
      aws.region = aws_config['region']
      aws.instance_type = "t2.micro"
      aws.security_groups= aws_config['security_groups']
      aws.associate_public_ip="true"
      #aws.elastic_ip= "false"
      #aws.elb="prod-askcharlie"
      aws.terminate_on_shutdown="false"
      
      
            
      aws.ami = instance_value['ami_id']
      aws.instance_type = instance_value['instance_type']
      aws.subnet_id = instance_value['subnet_id']
      aws.tags = {
			'Name' => ec2_tags['Name'],
			'Role' => ec2_tags['Role']
		}
      
      aws.block_device_mapping = [{ 
      'DeviceName' => '/dev/sda1', 
      'Ebs.VolumeSize' => 10, 
      'Ebs.VolumeType' => 'gp2', 
      'Ebs.DeleteOnTermination' => 'true' }]
      
      
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV['AWS_KEYPATH']

             
      config.vm.provision :docker
      config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", run: "always"
      
      end
     end 
       
  end
end
