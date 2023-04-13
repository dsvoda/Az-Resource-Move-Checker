# Azure Resource Move Checker

This repository contains Python and PowerShell scripts to check whether Azure resources can be moved to a different subscription.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Python Script](#python-script)
- [PowerShell Script](#powershell-script)
- [Contributing](#contributing)

## Overview

Moving Azure resources from one subscription to another can be a complex task, and requires careful planning and execution. This repository provides Python and PowerShell scripts that can help you check whether a given set of Azure resources can be moved to a different subscription.

The Python script `azure_resource_move_checker.py` scrapes Microsoft Doc's GitHub page for a list of non-movable resources and saves it to a JSON file named `NonMovableResources.json`. The PowerShell script `Test-AzResourceMove.ps1` imports this JSON file into an array and checks each resource in the source subscription against this list to determine whether it can be moved or not. The result of the check is then written to a CSV file, which can be used to help plan and execute the resource move.

## Prerequisites

- Azure Subscription
- Python 3.7 or higher (for Python Script)
- PowerShell 5.1 or higher (for PowerShell Script)
- Azure PowerShell module
- json
- re
- requests

## Python Script

The `azure_resource_move_checker.py` script is written in Python and uses the `requests` module to scrape Microsoft Doc's GitHub page for a list of non-movable resources. It then saves the list to a JSON file named `NonMovableResources.json`.

To run the Python script, follow these steps:

1. Clone this repository to your local machine.
2. Open a terminal or command prompt and navigate to the root directory of the repository.
3. Run the following command to install the required Python packages:
`pip install -r requirements.txt`
4. Run the following command to execute the script:
`python azure_resource_move_checker.py`
5. The script will generate a JSON file named `NonMovableResources.json` in the root directory of the repository.

## PowerShell Script

The `Test-AzResourceMove.ps1` script is written in PowerShell and uses the Azure PowerShell module to retrieve the list of resources in the source subscription. It then checks each resource against the list of non-movable resources in the `NonMovableResources.json` file, and writes the result of the check to a CSV file.

To run the PowerShell script, follow these steps:

1. Clone this repository to your local machine.
2. Open a PowerShell terminal and navigate to the root directory of the repository.
3. Run the following command to execute the script:
`.\Test-AzResourceMove.ps1`
4. The script will generate a CSV file named `AzResourceMoveCheck.csv` in the `C:\temp` directory.

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request with any improvements or bug fixes.
