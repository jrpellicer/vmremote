# vmremote
Creación remota de máquinas virtuales desde un servidor, proporcionando el disco duro con el sistema operativo instalado.

## Estructura de Archivos

* `/discos/` contiene los archivos vdi de los discos a copiar para la máquina virtual.
* `/scripts/` carpeta para los scripts de creación de las máquinas.
* `hosts.cfg` archivo con las direcciones de las máquinas a instalar

## Requerimientos
Para el funcionamiento es necesario tener instalado los siguienmtes programas.

En la máquina servidor:
* `ansible`
* `python`
* `pipx` (recomendado) o `pip`

Los hosts clientes deben ser máquinas Linux con los siguientes programas instalados:
* `openssh-server`
* `python`
* virtualbox

Se debe comprobar previamente la conexión por ssh mediante clave privada desde el servidor a todos los hosts.

# ansible

## Requerimientos para ansible

Instalación de `pipx`:

```zsh
sudo apt install pipx
pipx ensurepath
```

## Instalación de ansible

La instalación se hace en línea de comandos dentro del directorio del repositorio:

```zsh
pipx install ansible-core
```

Verificamos el funcionamiento:

```zsh
ansible --version
```

## Copia de las claves públicas a los hosts clientes

A cada máquina cliente que tengamos se le copiará, si no se ha hecho ya, la clave pública de la máquina servidor:

```zsh
ssh-copy-id usuario@11.22.33.44
```

Se comprueba la conexión una por una. Paso necesario.

```zsh
ssh usuario@11.22.33.44
```

## Configuración del entorno

La configuración se hace dentro del directorio del repositorio.

* En el archivo `ansible.cfg` se indica la ubicación del fichero de inventario de hosts. No es necesario modificarlo.
* En el archivo `hosts.cfg` se detallan las IPs de las máquinas cliente y los usuarios con los que se conectará el ssh.

### Comprobación del funcionamiento
```zsh
ansible all -m ping
```

# Lanzamiento del proceso

## Variables para la creación de las máquinas

En el playbook hay que definir las siguientes variables por cada máquina virtual a crear:

* `vdi_file` nombre y ubicación del fichero `.vdi` de la máquina a crear. La ruta será `./discos/`
* `remote_dir` directorio remoto de la máquina host donse se copiará el fichero `.vdi`
* `remote_vdi_path` ruta completa con el nombre del archivo `.vdi` a adjuntar a la máquina virtual.
* `vm_name` nombre de la máquina virtual a crear.
* `os_type` tipo de sistema operativo de la VM: `Windows11_64`, `Windows2019_64`, `Ubuntu24_LTS_64`, `Ubuntu_64`

## Ejecución del playbook

```zsh
ansible-playbook playbook.yml
```

