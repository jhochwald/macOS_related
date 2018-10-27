# ActiveDirectory

Scripts I use with [NoMAD](https://nomad.menu/products/) and [ControlPlane](https://www.controlplaneapp.com).

## Requirements

Download and Install [NoMAD](https://nomad.menu/products/).

Option: Execute the following

``` shell
sudo defaults write /Library/Preferences/com.apple.NetworkAuthorization AllowUnknownServers -bool YES
```

Otherwise new users will be prompted to approve any new servers.

## MountAdHome

[MountAdHome](MountAdHome) is a script that mount the Homedirectory. Is uses the information that it gets from [NoMAD](https://nomad.menu/products/).
[MountAdHome](MountAdHome) will check if the mount is needed or not.

## UnmountAdHome

[UnmountAdHome](UnmountAdHome) is a script that dismounts the Homedirectory, if needed. Is uses the information that it gets from [NoMAD](https://nomad.menu/products/).

## StateChangeAction

[StateChangeAction](StateChangeAction) is a script that my Mac executes whenever a network change is detected by [NoMAD](https://nomad.menu/products/) or a profile is changed by [ControlPlane](https://www.controlplaneapp.com).
It try to reach the Login Domain Controller found by [NoMAD](https://nomad.menu/products/). If the Domain controller is reachable it checks if the HoneDirectory is mounted or not, if not it will mount if by execute [MountAdHome](MountAdHome). If the Domain Controller is unreachable, it will execute [UnmountAdHome](UnmountAdHome) to unmount the drive (if needed)

## License

Copyright (c) 2018, Joerg Hochwald
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

