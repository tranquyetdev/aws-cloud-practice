# simple-nextjs-app

- [Preview URL](https://preview.sna.sandbox.quyettran.com/)

# ECS Task Definition

```bash
aws ecs describe-task-definition \
   --task-definition acp-preview-sna-service \
   --query taskDefinition > apps/simple-nextjs-app/task-definition.json \
   --region ap-southeast-1
```
