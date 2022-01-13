import psycopg2
import psycopg2.extras
import serial
import schedule
import time
import requests
import json
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
#ID,CODE,LATITUDE,LONGITUDE,ROW,COLUMN,INTENSITY,DATE

SERIALPORT = "/dev/ttyS5"
BAUDRATE = 115200
ser = serial.Serial()
IP_HOST = "192.168.43.186"
key = b'\xa1\x52\xff\x94\xc6\xf5\x0d\xbc\x48\x98\xb6\x9d\xc7\xaf\x6d\x1b\x44\x35\xf8\x81\xe7\x65\x8b\x9b\xd5\xd4\x16\xd5\x4a\x97\x0f\x8d'
initialisation_vector=b'\x99\x24\x02\xc0\x0f\x1f\x20\xb7\x9d\x19\xf9\x32\x1f\x0f\x72\xa6'

def decript_message(encrypted_message,nb_elements):
    cipher_decrypt = AES.new(key, AES.MODE_CFB, iv=initialisation_vector,segment_size=8)
    message = cipher_decrypt.decrypt(encrypted_message)
    for i in range(nb_elements):
            id = int.from_bytes(message[(i*4):(i*4)+2], byteorder='big')
            type = message[(i*4)+2]
            val = message[(i*4)+3]
            print("%d,%d,%d" % (id,type,val))


def get_data_from_db_and_send_to_uart():
    global ser
    nb_try=0
    msg_list = list()
    while nb_try<3:
        try:
            req = requests.get('http://%s:5000/api/capteur_donnees' % (IP_HOST))
            if req.status_code ==200:
                response = req.json()
                #print(response) 
                for row in response:         
                    sensor_id = int(row['id'])
                    msg_type = int(row['type_id'])
                    value = int(row['value'])
                    msg_as_list=list()
                    msg_as_list.append(sensor_id)
                    msg_as_list.append(msg_type)
                    msg_as_list.append(value)
                    msg_list.append(msg_as_list)
                    print("id=%d,type=%d,value=%d" % (sensor_id,msg_type,value))
                
                #print("VALUE DICT")
                msg = b''
                nb_element_to_send=0
                for msg_as_list in msg_list:
                    value= msg_as_list[2]
                    sensor_id=msg_as_list[0]
                    msg_type=msg_as_list[1]
                    #print("id=%d,type=%d,value=%d" % (sensor_id,msg_type,value_dict[sensor_id][msg_type]))
                    sensor_id_as_bytes = sensor_id.to_bytes(2,byteorder='big')
                    msg_type_as_bytes =  msg_type.to_bytes(1,byteorder='big') 
                    value_as_bytes = value.to_bytes(1,byteorder='big')
                    msg+= sensor_id_as_bytes+msg_type_as_bytes+value_as_bytes
                    nb_element_to_send+=1
                    if(nb_element_to_send==60):
                        nb_element_to_send_as_bytes =  nb_element_to_send.to_bytes(1,byteorder='big')
                        #print(nb_element_to_send_as_bytes+msg)
                        cipher_encrypt = AES.new(key, AES.MODE_CFB,iv=initialisation_vector)
                        encrypted_message=cipher_encrypt.encrypt(msg)
                        ser.write(nb_element_to_send_as_bytes+encrypted_message)
                        #print("Message <" + str(nb_element_to_send_as_bytes+msg) + "> <"+str(len(msg))+"> sent to micro-controller." )

                        print("Message <" + str(encrypted_message.hex()) + "><"+str(nb_element_to_send) +"> <"+str(len(encrypted_message))+"> sent to micro-controller." )
                        print()
                        #decript_message(encrypted_message,nb_element_to_send)
                        msg=b''
                        nb_element_to_send=0
                        time.sleep(0.16)
                        # print("UART ANSWER")
                        # uart_ret=ser.readline().hex()
                        # print(uart_ret)
                        # print(uart_ret==(nb_element_to_send_as_bytes+encrypted_message).hex())

                if(nb_element_to_send>0):
                    nb_element_to_send_as_bytes =  nb_element_to_send.to_bytes(1,byteorder='big')
                    cipher_encrypt = AES.new(key, AES.MODE_CFB,iv=initialisation_vector)
                    encrypted_message=cipher_encrypt.encrypt(msg)
                    ser.write(nb_element_to_send_as_bytes+encrypted_message)
                    #print(len(msg))
                    #print("Message <" + str(nb_element_to_send_as_bytes+msg) + "> <"+str(len(msg))+"> sent to micro-controller." )
                    print("Message <" + str(encrypted_message.hex()) + "><"+str(nb_element_to_send) +"> <"+str(len(encrypted_message))+"> sent to micro-controller." )
                    print()
                    #decript_message(encrypted_message,nb_element_to_send)
                    msg=b''
                    nb_element_to_send=0
                    time.sleep(0.16)
                
                # f = open("logmicrobit.txt", "ab")
                # while ser.in_waiting:  # Or: while ser.inWaiting():
                #     f.write(ser.readline())
                # f.close()
            return
        except Exception as e:
            print(e)
            print("Failed to send data to uart "+str(e))
            nb_try+=1

def initUART():     
    # ser = serial.Serial(SERIALPORT, BAUDRATE)
    ser.port=SERIALPORT
    ser.baudrate=BAUDRATE
    ser.bytesize = serial.EIGHTBITS #number of bits per bytes
    ser.parity = serial.PARITY_NONE #set parity check: no parity
    ser.stopbits = serial.STOPBITS_ONE #number of stop bits
    ser.timeout = None          #block r    
    # ser.timeout = 0             #non-block read
    # ser.timeout = 2              #timeout block read
    ser.xonxoff = False     #disable software flow control
    ser.rtscts = False     #disable hardware (RTS/CTS) flow control
    ser.dsrdtr = False       #disable hardware (DSR/DTR) flow control
    #ser.writeTimeout = 0     #timeout for write
    print ("Starting Up Serial Monitor")
    try:
        ser.open()
    except serial.SerialException:
        print("Serial {} port not available".format(SERIALPORT))
        exit()
                
                
try:
    initUART()
except Exception as e:
    print("Failed to init UART "+str(e))
    exit(-1)

schedule.every(5).seconds.do(get_data_from_db_and_send_to_uart)

while 1:
    schedule.run_pending()
    time.sleep(1)
    

