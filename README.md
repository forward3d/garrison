Garrison
--

Garrison is a security service for consolidating alerts from many other systems down
to a single web dashboard.

![Garrison UI](https://raw.githubusercontent.com/forward3d/garrison/master/docs/screenshot.png)

### Preface

Garrison is made up of two parts...

1. Dashboard
2. Agents

#### Web interface

A Ruby on Rails web app, which utilizes a PostgreSQL database for alert storage.

#### Agents

These populate the alerts you see in the dashboard, they are primarily lightweight docker containers. They are responsible for sending data to the web API which populates the interface.

There are some pre-built agents, but you can create your own agents very easily if you need to.

### Installation

We provide pre-build Docker containers for all parts of the service which are available on Docker Hub.

* Dashboard - https://hub.docker.com/r/forward3d/garrison/
* Agents - See individual agent documentation

### Configuration

#### Dashboard

TODO

#### Agents

There are some global configuration options for agents, these are provided to the agent containers via environmental variables. Some agents may have additional configuration options, however these will be documented with the individual agent.

##### Global Configuration Options (Mandatory)

| Environmental Variable  | Description |
| ------------- | ------------- |
| `GARRISON_URL`  | URL to the Garrison web interface eg. `https://garrison.internal.acme.com` |

##### Global Configuration Options (Optional)

All optional variables will contain a sane default by the individual check itself, these options are provided for if you want to override that default.

| Environmental Variable  | Description |
| ------------- | ------------- |
| `GARRISON_ALERT_SOURCE` | Source slug eg. 'aws-rds', 'cve-detail' |
| `GARRISON_ALERT_SEVERITY` | Severity slug eg. `critical`, `high`, `medium`, `low`, `info` [[1]](#f1) |
| `GARRISON_ALERT_FAMILY` | Family slug eg. `attack`, `infrastructure`, `software`, `networking` [[1]](#f1) |
| `GARRISON_ALERT_TYPE` | Type slug eg. `security`, `compliance`, `informational` [[1]](#f1) |
| `GARRISON_ALERT_DEPARTMENTS` | Comma Separated list of Department slugs eg. `it,development` [[2]](#f2) |

1. <span id="f1"></span> Or any other custom ones you have created within Garrison.
2. <span id="f2"></span> Departments must already exist.

### Available Agents

| Name  | Description |
| ------------- | ------------- |
| [AWS RDS](https://github.com/forward3d/garrison-agent-aws-rds) | Compliance checks, encryption enabled, backup retention etc |
