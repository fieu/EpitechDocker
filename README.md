<h1 align="center">
  <br>
  <a href="https://github.com/fieu/EpitechDocker"><img src="https://i.imgur.com/23tTkdY.gif" alt="EpitechDocker" width="200"></a>
  <br>
  <br>
  <code>EpitechDocker</code>
  <br>
  <br>
</h1>

<h4 align="center">Epitech Docker setup optimized for C/C++ development</h4>

<p align="center">
  <a href="https://epitech.eu"><img src="https://img.shields.io/badge/school-epitech-brightgreen" alt="school"></a>
  <a href="https://github.com/webtorrent/webtorrent/actions"><img src="https://img.shields.io/badge/moulinette-nsm-green" alt="ci"></a>
  <a href="https://en.wikipedia.org/wiki/RTFM"><img src="https://img.shields.io/badge/seb-%3C3-ff69b4"></a>
</p>

<h5 align="center">
  Sponsored by&nbsp;&nbsp;&nbsp;&nbsp;<a href="https://storme.io" rel="nofollow"><img src="https://i.imgur.com/k8f4tuI.png" alt="Storme" height=35 valign="middle"></a>
</h5>
<br>

<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
        <li><a href="#temporary-work-environment">Temporary Work Environment</a></li>
        <li><a href="#ssh-enabled-container">SSH Enabled Container</a></li>
      </ul>
    </li>
    <li><a href="#updating">Updating</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## About The Project

I decided to publish my Docker cause the one [Epitech/epitest-docker](https://github.com/Epitech/epitest-docker/) is full of bloated languages and tools like Java, Python, and a bunch of other shit that you probably don't use. Let's be honest, at Epitech you're only writing C and C++.

## Getting Started

### Prerequisites

You're gonna need a couple things
* Docker 🐳 (Technical Preview if on an M1 silicon based Mac)
* A brain 🧠

### Installation

1. Clone the repo
    ```sh
    git clone https://github.com/fieu/EpitechDocker.git ~/docker
    ```
2. Build the Docker image
    ```sh
    cd ~/docker
    # Linux/Intel based Macs
    make
    # M1 silicon based Macs
    make m1
    ```
### Usage

#### Temporary Work Environment
> Perfect for quick hacking, offline development, and also if you're broke 🙃

The command to launch the container can be annoying to remember, so here are some easy to use aliases you can throw in your `~/.bashrc` or `~/.zshrc`.
```sh
# Launch container
alias fedora='docker run -it --name "epitech-fedora" --rm -v $(pwd):/work --cap-add SYS_PTRACE epitech-fedora'
# Open shell in running container
alias sh-fedora="docker exec -it epitech-fedora /bin/bash"
```
**Note:** The launch commands will map your current directory to `/work` within the container. Good rule of thumb is to run the `fedora` alias in your project root.

#### SSH Enabled Container
> Good for when you have access to a server and don't want to replace the OS but have a Fedora environment. Can be paired with the Visual Studio Code [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh) extension to provide a full work environment like you are used to in VS Code, though everything is saved and terminal commands are executed in the container.

You can run the container in as a long-term service that will stay alive until you kill the container.

Set the `SSH_PASSWORD` environment variable and map the SSH server port to enable the SSH server on boot of the container.
Example:
```sh
docker run -it \
  --name "epitech-fedora" \
  -v "/home/user/work:/work" \
  --cap-add SYS_PTRACE \
  -e SSH_PASSWORD="SuperSecureP@ssword123" \
  -p 2022:22 \
  epitech-fedora
```

### Updating

In order to update, simply pull from upstream and rebuild the image.
```sh
cd ~/docker
git pull
# Linux/Intel based Macs
make
# M1 silicon based Macs
make m1
```

## Contributing

Not sure what you would want to contribute, but if you want, be my guest.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Sheldon Rupp - [@0xF13U](https://twitter.com/0xF13U) - me *at* fieu.cc
