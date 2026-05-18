resource "aws_cloudwatch_log_group" "bootstrap" {
    name = "cloudshelf/bootstrap"
    retention_in_days = 30

    tags = {
      Project = var.project
    }
}

resource "aws_cloudwatch_log_group" "docker" {
    name = "cloudshelf/docker"
    retention_in_days = 30

    tags = {
      Project = var.project
    }
}

resource "aws_sns_topic" "alerts" {
  name = "cloudshelf-alerts"

  tags = {
    Project = var.project
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cloudshelf-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "EC2 CPU utilisation above 80% for 10 minutes"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = {
    Project = var.project
  }
}