module "fargate-orchestrator-agent" {
  source  = "sysdiglabs/fargate-orchestrator-agent/aws"
  version = "0.1.1"

  vpc_id = aws_vpc.vpc.id
  subnets = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  access_key = var.access_key
  # True if the VPC uses an InternetGateway, false otherwise
  assign_public_ip = true
  
  collector_host = var.collector_host
  collector_port = var.collector_port

  name        = "sysdig-orchestrator"
  agent_image = "quay.io/sysdig/orchestrator-agent:latest"

  tags = {
    description = "Sysdig Serverless Agent Orchestrator"
  }
}

output "agent_orch_host" {
  value = module.fargate-orchestrator-agent.orchestrator_host
}

output "agent_orch_port" {
  value = module.fargate-orchestrator-agent.orchestrator_port
}
