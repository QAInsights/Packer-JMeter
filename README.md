[![contributions welcome](https://img.shields.io/badge/contributions-welcome-1EAEDB)]()
[![saythanks](https://img.shields.io/badge/say-thanks-1EAEDB.svg)](https://saythanks.io/to/catch.nkn%40gmail.com)
[![](https://img.shields.io/badge/license-MIT-0a0a0a.svg?style=flat&colorA=1EAEDB)](https://qainsights.com)
[![](https://img.shields.io/badge/%E2%9D%A4-QAInsights-0a0a0a.svg?style=flat&colorA=1EAEDB)](https://qainsights.com)
[![](https://img.shields.io/badge/%E2%9D%A4-YouTube%20Channel-0a0a0a.svg?style=flat&colorA=1EAEDB)](https://www.youtube.com/user/QAInsights?sub_confirmation=1)
[![](https://img.shields.io/badge/donate-paypal-1EAEDB)](https://www.paypal.com/paypalme/NAVEENKUMARN)

# JMeter Packer

This repo creates custom AMI for JMeter on AWS.

# Prerequisites

* Packer
* AWS Console Access

# Usage

* Install Packer
* `git clone https://github.com/QAInsights/Packer-JMeter.git`
* `cd Packer-JMeter\file` or `cd Packer-JMeter\shell`
* `packer build .`
* Wait for a moment, typically it will take 3-5 minutes to create the AMI.
* The output contains the AMI ID and Region. 
```
amazon-ebs.jmeter: output will be in this color.

==> amazon-ebs.jmeter: Prevalidating any provided VPC information
==> amazon-ebs.jmeter: Prevalidating AMI Name: jmeter_1643499054
    amazon-ebs.jmeter: Found Image ID: ami-001089eb624938d9f
...
...
...
...
==> amazon-ebs.jmeter: No volumes to clean up, skipping
==> amazon-ebs.jmeter: Deleting temporary security group...
==> amazon-ebs.jmeter: Deleting temporary keypair...
Build 'amazon-ebs.jmeter' finished after 3 minutes 59 seconds.

==> Wait completed after 3 minutes 59 seconds

==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs.jmeter: AMIs were created:
us-east-2: ami-095b20c4727d864cb
```
* Copy the AMI ID to spin up the instance on AWS.

# AMI Specifications

The AMI is created with the following specifications:

- Java Corretto 
- Apache JMeter 5.4.3
- JMeter Plugins: jpgc-casutg,jpgc-functions
- `us-east-2` region
- Base image: `amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2`
- Owner: `137112412989`

# Customize the specifications

To customize the AMI, open `jmeter-amazon.pkr.hcl` file and change the specifications.

# References

- https://apache.jmeter.org
- https://packer.io
- https://aws.amazon.com