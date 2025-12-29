# Salesforce Developer Environment

[![CI Workflow](https://github.com/JordanParra96/Salesforce_DevEnv/workflows/CI/badge.svg)](https://github.com/JordanParra96/Salesforce_DevEnv/actions?query=workflow%3ACI)[![codecov](https://codecov.io/gh/JordanParra96/Salesforce_DevEnv/branch/master/graph/badge.svg)](https://codecov.io/gh/JordanParra96/Salesforce_DevEnv)

This repository contains all metadata related to my personal dev environment, I do some experiments and test new features that I am encouredge in my Salesforce journey 😄

> [!IMPORTANT]
> As it is an environment where I do testing, it is highly likely that not everything that is there follows 100% best practices and the latest trends, it is just a guide. 🏖️

## Table of contents

- [Wiki Page](#wiki-page)

- [CI Workflow](#ci-workflow)

- [codecov](#codecov)

## Wiki Page

You can find in the Wiki page of this repository a set of best practices and tips that I have found on my way through Salesforce, this could help to facilitate the implementations and optimize the solutions, I invite you to take a look [Wiki Page](https://github.com/JordanParra96/Salesforce_DevEnv/wiki).

## CI Workflow

For this repository I implemented a CI flow in which validations are performed for both LWC code (using prettier and eslint) and Apex code (using prettier), in addition to this a validation of test classes is performed (both for LWC and apex) in which I try to ensure the quality of the code that is implemented and uploaded to the main branch, the complete implementation can be seen in the wiki [CI/CD Pipeline](https://github.com/JordanParra96/Salesforce_DevEnv/wiki/CI%2FCD-Pipeline).

## Codecov

Once the validation of the organization's code is done, the report of the status, coverage, lines covered, percentage, is uploaded to the codecov page ([codecov](https://about.codecov.io/)), the complete configuration and how to implement this can be found in the wiki `page in progress`.
