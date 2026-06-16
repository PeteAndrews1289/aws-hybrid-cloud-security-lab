# AWS Hybrid Cloud Lab Detection Queries

These Splunk queries were developed for CloudTrail logs imported as nested JSON records. They demonstrate how raw AWS logs can be parsed into useful security searches.

## Base CloudTrail Parser

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
```

Purpose: expands CloudTrail `Records` arrays into individual searchable events.

## Top AWS API Actions

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| stats count by eventName
| sort -count
```

Observed value: common actions included `DescribeAlarms`, `DescribeAddresses`, `DescribeSecurityGroups`, and `GetBucketLogging`.

## EC2 Activity

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| search eventSource="ec2.amazonaws.com"
| table eventTime eventName userIdentity.arn sourceIPAddress requestParameters.instanceId errorCode
| sort -eventTime
```

Security value: EC2 events reveal infrastructure activity such as describing instances, security groups, key pairs, and regions.

## Failed API Calls

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| search errorCode=*
| table eventTime eventSource eventName errorCode errorMessage userIdentity.arn sourceIPAddress
| sort -eventTime
```

Observed value: the lab detected `GetInsightSelectors` returning `InsightNotEnabledException`, showing how failed activity can be surfaced.

## Identity-Based Activity

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| stats count values(eventName) as actions values(eventSource) as services by userIdentity.arn sourceIPAddress
| sort -count
```

Security value: groups AWS activity by actor so analysts can understand who performed actions and from where.

## Security Group Changes

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| search eventName IN ("AuthorizeSecurityGroupIngress","AuthorizeSecurityGroupEgress","RevokeSecurityGroupIngress","RevokeSecurityGroupEgress","CreateSecurityGroup","DeleteSecurityGroup")
| table eventTime eventName userIdentity.arn sourceIPAddress requestParameters.groupId requestParameters.groupName errorCode
| sort -eventTime
```

Security value: security group changes can affect public exposure and should be reviewed in a segmented VPC lab.

## Service Activity Over Time

```spl
index=* sourcetype=_json
| spath path=Records{} output=record
| mvexpand record
| spath input=record
| timechart span=1h count by eventSource
```

Security value: helps identify unusual spikes or shifts in AWS service usage.

## Security Insight

CloudTrail provides strong visibility into AWS control-plane activity, but it does not capture SSH sessions, shell commands, process execution, or detailed network scans. This lab should be paired with host logs and VPC Flow Logs for deeper coverage.
