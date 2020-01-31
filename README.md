# First steps

First, is necessery access using API Gitlab, the JSON list of all git projects. [Here](https://docs.gitlab.com/ee/api/projects.html) is possible access gitlab Project API Documentation. Pain atention to configure the max project in a request, the max number projects in one request is 100.

In my case, I sent to gitlab API this params:

```bash
page: is used to set the page 
sort: is used to set the sort list, I used asc
per_page: number of registers per page, max is 100
```

I used this to transfer 217 gitlab projects, then was necessery process 3 times this request.

The shell script described in this readme use all this json files and send to Codecommit.

Is necessery that this json files using this nomenclature: gitlab-projects-p<page_number>.json . The page number will be used like param in script execution.

This script considere that you already set the aws cli access with permitions to operate CodeCommit.

The path /home/user/migration-gitlab-to-awscodecommit/ needs replaced to your case.

## Installation and Usage

Basic, clone this project, configure aws cli access and download the json list projects.

```bash
#chmod +x migracao-gitlab.sh
# ./migracao-gitlab.sh 1
```
where 1 is the gitlab page of projects, when you have more than 100 projects at gitlab

The script verifica.sh is used to verify the success operation of this main script. It will save the fail sent projects in resultado.txt
