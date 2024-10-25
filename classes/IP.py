"""IP Address Model Class"""  # pylint: disable=invalid-name


class IP:
    """IP"""

    class Address:
        """IP Address"""

        def __init__(self, ip_address: str):
            self.ip_address = ip_address
            self.octets = self.ip_address.split(".")
            self.octet1 = int(self.octets[0])
            self.octet2 = int(self.octets[1])
            self.octet3 = int(self.octets[2])
            self.octet4 = int(self.octets[3])

        def __str__(self):
            return self.ip_address

    class Network:
        """IP Network"""

        def __init__(self, ip_address: str, block_size: int):
            self.__ip = IP.Address(ip_address)
            self.block_size = block_size
            self.att_primary_dns = "68.94.156.1"
            self.att_secondary_dns = "68.94.157.1"

        @property
        def network_ip(self):
            """Network Address"""
            return self.__ip.ip_address

        @property
        def first_usable(self):
            """First Usable Address"""
            base = f"{self.__ip.octet1}.{self.__ip.octet2}.{self.__ip.octet3}"
            octet4 = self.__ip.octet4 + 1
            return f"{base}.{octet4}"

        @property
        def last_usable(self):
            """Last Usable Address"""
            base = f"{self.__ip.octet1}.{self.__ip.octet2}.{self.__ip.octet3}"
            octet4 = self.__ip.octet4 + self.block_size - 3
            return f"{base}.{octet4}"

        @property
        def default_gateway(self):
            """Default Gateway Address"""
            base = f"{self.__ip.octet1}.{self.__ip.octet2}.{self.__ip.octet3}"
            octet4 = self.__ip.octet4 + self.block_size - 2
            return f"{base}.{octet4}"

        @property
        def broadcast_address(self):
            """Broadcast Address"""
            base = f"{self.__ip.octet1}.{self.__ip.octet2}.{self.__ip.octet3}"
            octet4 = self.__ip.octet4 + self.block_size - 1
            return f"{base}.{octet4}"

        @property
        def subnet_mask(self):
            """Subnet Mask"""
            match self.block_size:
                case 8:
                    return "255.255.255.248"
                case 16:
                    return "255.255.255.240"
                case 32:
                    return "255.255.255.224"
                case 64:
                    return "255.255.255.192"
                case _:
                    return "UNKNOWN"
