<details>
  <summary>Table of Contents</summary>
  
  - [EPP-systemd](#epp-systemd)
  - [Dependencies](#dependencies)
  - [Installation](#installation)
  - [Uninstallation](#uninstallation)

</details>

> Currently, it only supports AMD processors and is being tested on my laptop powered by an AMD Ryzen 7 7840HS that runs Fedora 40. I don't have an Intel machine to learn about `intel_pstate`. If you have an Intel machine and would like to contribute, please do so (see [#4](https://github.com/realKarthikNair/EPP-systemd/issues/4)).

# EPP-systemd

Set Energy Performance Preference based on charging status and battery capacity.

Currently, it does this:
- If plugged in, sets to `performance` if battery capacity is greater than 50, else sets to `balance_performance`.
- If not plugged in, sets to `balance_performance` if battery capacity is greater than 50, else sets to `power`.


# Dependencies

- Your distro must have systemd.
- The `amd_pstate_epp` scaling driver must be installed/enabled. Running `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver` will return `amd-pstate-epp` if it is enabled.

# Installation

1. Clone the repository and change into the directory.

    ```bash
    git clone https://github.com/realKarthikNair/EPP-systemd
    cd EPP-systemd
    ```

2. Customize thresholds and EPP by editing `cpu_performance_config.conf` if needed. The file is self explanatory.

3. Run `install-and-enable.sh` after making it executable to install the service and enable it.

    ```bash
    chmod +x install-and-enable.sh
    ./install-and-enable.sh
    ```

# Uninstallation

1. Run `uninstall.sh` after making it executable to uninstall the service.

    ```bash
    chmod +x uninstall.sh
    ./uninstall.sh
    ```
