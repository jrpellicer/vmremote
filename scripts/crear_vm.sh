#!/bin/bash

VM_NAME="$1"
OS_TYPE="$2"
VDI_PATH="$3"

echo "Ruta del VDI: $VDI_PATH"
echo "Nombre de la VM: $VM_NAME"
echo "Tipo de sistema operativo: $OS_TYPE"

VM_NAME="Windows 2019"
VDI_PATH="/home/ciclot/Windows Server 2019.vdi"

echo "Creando la máquina virtual...  '$VM_NAME'"
VBoxManage createvm --name "$VM_NAME" --ostype "$OS_TYPE" --register

echo "Configurando hardware..."
VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2 --nic1 intnet

echo "Añadiendo disco duro..."
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 \
  --device 0 \
  --type hdd \
  --medium "$VDI_PATH"

echo "Máquina Virtual '$VM_NAME' creada y lista para iniciar."