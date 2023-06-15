#
# codepipeline - demo
#
resource "aws_codepipeline" "demo" {
  name     = "demo-docker-pipeline"
  role_arn = aws_iam_role.demo-codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.demo-artifacts.bucket
    type     = "S3"
    encryption_key {
      id   = aws_kms_alias.demo-artifacts.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["demo-docker-source"]
      configuration = {
        ConnectionArn    = "arn:aws:codestar-connections:eu-west-1:474165608704:connection/06f9395c-8aef-4f4c-a6db-ea10db9c9f17"
        FullRepositoryId = "aw-birdgang/nestjs-api-pipeline"
        BranchName       = "develop"
      }
    }
  }

#  stage {
#    name = "Source"
#
#    action {
#      name             = "Source"
#      category         = "Source"
#      owner            = "AWS"
#      provider         = "CodeCommit"
#      version          = "1"
#      output_artifacts = ["demo-docker-source"]
#      configuration = {
#        RepositoryName = aws_codecommit_repository.demo.repository_name
#        BranchName     = "master"
#      }
#    }
#  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["demo-docker-source"]
      output_artifacts = ["demo-docker-build"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.demo.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["demo-docker-build"]
      version         = "1"

      configuration = {
        ApplicationName                = aws_codedeploy_app.demo.name
        DeploymentGroupName            = aws_codedeploy_deployment_group.demo.deployment_group_name
        TaskDefinitionTemplateArtifact = "demo-docker-build"
        AppSpecTemplateArtifact        = "demo-docker-build"
      }
    }
  }
}


