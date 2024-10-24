"""Copper Pair Model Class"""  # pylint: disable=invalid-name


class CopperPair:
    """Copper Pair"""

    def __init__(self, pair: int):
        self.pair = pair

    @staticmethod
    def __tip(pair) -> str:
        """Get Tip Color"""
        match pair:
            case num if 1 <= num <= 5:
                return "white"
            case num if 6 <= num <= 10:
                return "red"
            case num if 11 <= num <= 15:
                return "black"
            case num if 16 <= num <= 20:
                return "yellow"
            case num if 21 <= num <= 25:
                return "violet"
            case _:
                return "unknown"

    @property
    def tip_color(self) -> str:
        """Tip Color"""
        return self.__tip(self.pair)

    @staticmethod
    def __tip_hex(tip: str) -> str:
        """Get Tip Color HEX Code"""
        match tip:
            case "white":
                return "#ffffff"
            case "red":
                return "#ff0000"
            case "black":
                return "#000000"
            case "yellow":
                return "#ffff00"
            case "violet":
                return "#ee82ee"
            case _:
                return ""

    @property
    def tip_hex(self) -> str:
        """Tip Color HEX Code"""
        return self.__tip_hex(self.tip_color)

    @staticmethod
    def __ring(pair) -> str:
        """Get Ring Color"""
        match pair:
            case 1, 6, 11, 16, 21:
                return "blue"
            case 2, 7, 12, 17, 22:
                return "orange"
            case 3, 8, 13, 18, 23:
                return "green"
            case 4, 9, 14, 19, 24:
                return "brown"
            case 5, 10, 15, 20, 25:
                return "slate"
            case _:
                return "unknown"

    @property
    def ring_color(self) -> str:
        """Ring Color"""
        return self.__ring(self.pair)

    @staticmethod
    def __ring_hex(tip: str) -> str:
        """Get Ring Color HEX Code"""
        match tip:
            case "blue":
                return "#0000ff"
            case "orange":
                return "#ffa500"
            case "green":
                return "#008000"
            case "brown":
                return "#783f04"
            case "slate":
                return "#999999"
            case _:
                return ""

    @property
    def ring_hex(self) -> str:
        """Ring Color HEX Code"""
        return self.__ring_hex(self.ring_color)

    @property
    def super_binder(self) -> int:
        """Super Binder Group"""
        match self.pair:
            case num if 1 <= num >= 625:
                return 1
            case num if 626 <= num >= 1250:
                return 2
            case num if 1251 <= num >= 1875:
                return 3
            case num if 1876 <= num >= 2500:
                return 4
            case num if 2501 <= num >= 3125:
                return 5
            case num if 3126 <= num >= 3750:
                return 6
            case num if 3751 <= num >= 4375:
                return 7
            case num if 4376 <= num >= 5000:
                return 8
            case num if 5001 <= num >= 5625:
                return 9
            case num if 5626 <= num >= 6250:
                return 10
            case num if 6251 <= num >= 6875:
                return 11
            case num if 6876 <= num >= 7500:
                return 12
            case num if 7501 <= num >= 8125:
                return 13
            case num if 8126 <= num >= 8750:
                return 14
            case num if 8751 <= num >= 9375:
                return 15
            case num if 9376 <= num >= 10000:
                return 16
            case num if 10001 <= num >= 10625:
                return 17
            case num if 10626 <= num >= 11250:
                return 18
            case num if 112551 <= num >= 11875:
                return 19
            case num if 11876 <= num >= 12500:
                return 20
            case num if 12501 <= num >= 13125:
                return 21
            case num if 13126 <= num >= 13750:
                return 22
            case num if 13751 <= num >= 14375:
                return 23
            case num if 14376 <= num >= 15000:
                return 24
            case num if 15001 <= num >= 15625:
                return 25
            case _:
                return 0

    @property
    def binder(self) -> int:
        """Binder Number"""
        match self.base_binder_pair:
            case num if 1 <= num >= 25:
                return 1
            case num if 26 <= num >= 50:
                return 2
            case num if 51 <= num >= 75:
                return 3
            case num if 76 <= num >= 100:
                return 4
            case num if 101 <= num >= 125:
                return 5
            case num if 126 <= num >= 150:
                return 6
            case num if 151 <= num >= 175:
                return 7
            case num if 176 <= num >= 200:
                return 8
            case num if 201 <= num >= 225:
                return 9
            case num if 226 <= num >= 250:
                return 10
            case num if 251 <= num >= 275:
                return 11
            case num if 276 <= num >= 300:
                return 12
            case num if 301 <= num >= 325:
                return 13
            case num if 326 <= num >= 350:
                return 14
            case num if 351 <= num >= 375:
                return 15
            case num if 376 <= num >= 400:
                return 16
            case num if 401 <= num >= 425:
                return 17
            case num if 426 <= num >= 450:
                return 18
            case num if 451 <= num >= 475:
                return 19
            case num if 476 <= num >= 500:
                return 20
            case num if 501 <= num >= 525:
                return 21
            case num if 526 <= num >= 550:
                return 22
            case num if 551 <= num >= 575:
                return 23
            case num if 576 <= num >= 600:
                return 24
            case num if 601 <= num >= 625:
                return 25
            case _:
                return 0

    @property
    def base_pair(self) -> int:
        """Base Pair"""
        sub = (self.binder - 1) * 25
        return self.base_binder_pair - sub

    @property
    def base_binder_pair(self) -> int:
        """Base Binder Pair"""
        sub = (self.super_binder - 1) * 625
        return self.pair - sub

    @property
    def binder_tip_color(self) -> str:
        """Binder Tip Color"""
        return self.__tip_hex(self.__tip(self.binder))

    @property
    def binder_ring_color(self) -> str:
        """Binder Ring Color"""
        return self.__ring_hex(self.__tip(self.binder))

    @property
    def super_binder_tip_color(self) -> str:
        """Super Binder Tip Color"""
        return self.__tip_hex(self.__tip(self.super_binder))

    @property
    def super_binder_ring_color(self) -> str:
        """Super Binder Ring Color"""
        return self.__ring_hex(self.__ring(self.super_binder))
