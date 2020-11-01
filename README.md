# SentimentalistsApp-Infrastructure

Shared infrastructure and terraform modules for [The Sentimentalists](https://thesentimentalists.github.io) article analysis service.

![Image of Architecture](https://github.com/TheSentimentalists/SentimentalistsApp-Infrastructure/blob/master/docs/architecture.jpg?raw=true)

## Folder Structure:

The SENTIMENTALISTSAPP-INFRASTRUCTURE is divided into the following folders:

### `infra/prod`
Contains the shared production environment terraform files for the API Gateway. This shared config is imported by terraform in other repos as a datasource (to add resources to the single API Gateway).

### `.github/workflows`
Contains the pipeline that updates the live environemnt with changes to `infra/prod`.

### `terraform/modules`
Contains modules used by other repos to deploy lambda functions and add them to the shared API gateway.
