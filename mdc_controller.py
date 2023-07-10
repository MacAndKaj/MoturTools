

FRAME_CTRL_DATA_SIZE = 1
MESSAGE_CTRL_DATA_SIZE = 1
HEADER_SIZE = (FRAME_CTRL_DATA_SIZE + MESSAGE_CTRL_DATA_SIZE)

FRAME_CTRL_DATA = 0xF0

class Controller:
    def send(self, data):
        pass


if __name__ == '__main__':
    print("Hello world")