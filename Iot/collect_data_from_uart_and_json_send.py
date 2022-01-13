import serial
import time
from paho.mqtt import client as mqtt_client
import datetime
import requests
import threading
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
#INFLUX DB 
#U:admin
#P:admincpe
#SERIALPORT = "/dev/ttyACM0"
SERIALPORT = "/dev/ttyS6"
BAUDRATE = 115200
ser = serial.Serial()

broker = 'localhost'
port = 1883
topic = "projet/sensor_data"
# generate client ID with pub prefix randomly
client_id = "microbit123"
# username = 'emqx'
# password = 'public'
IP_HOST = "192.168.43.144"
key = b'\xa1\x52\xff\x94\xc6\xf5\x0d\xbc\x48\x98\xb6\x9d\xc7\xaf\x6d\x1b\x44\x35\xf8\x81\xe7\x65\x8b\x9b\xd5\xd4\x16\xd5\x4a\x97\x0f\x8d'
initialisation_vector=b'\x99\x24\x02\xc0\x0f\x1f\x20\xb7\x9d\x19\xf9\x32\x1f\x0f\x72\xa6'


def connect_mqtt():
    client = mqtt_client.Client(client_id)
    #client.username_pw_set(username, password)
    #client.on_connect = on_connect
    client.connect(broker, port)
    return client

def publish(client,msg):
    msg_count = 0
    #time.sleep(0.05)
    result = client.publish(topic, msg)
    # result: [0, 1]
    status = result[0]
    if status == 0:
        print(f"Send `{msg}` to topic `{topic}`")
    else:
        print(f"Failed to send message to topic {topic}")
    msg_count += 1


def send_json(json_val,ip_host):
    req = requests.post('http://%s:5000/api/historique' % (ip_host), json = json_val)
    if req.status_code ==200:
        print("Data inserted into database sucessfully")

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

#time.sleep(3)
my_mqtt_client = connect_mqtt()
#my_mqtt_client.loop_start()
while 1:
    time.sleep(0.02)
    first_char=b''
    while first_char !=b'\x8d':
        first_char = ser.read(1)
        print(first_char)
    try:
        nb_elements_as_bytes = ser.read(1)
        nb_elements = int.from_bytes(nb_elements_as_bytes,'big')
        #print("NB:"+str(nb_elements))
        #if(nb_elements>60):
            #raise Exception("Bad message format")
        encrypted_message=b''
        for k in range(nb_elements):
            encrypted_message+=ser.read(4)
        cipher_decrypt = AES.new(key, AES.MODE_CFB, iv=initialisation_vector,segment_size=8)
        message = cipher_decrypt.decrypt(encrypted_message)
        print("NB ELEMENTS BYTES:"+str(nb_elements_as_bytes))
        print("NB ELEMENTS:"+str(nb_elements))
        #print("MSG:"+str(message))
        print("MSG_ENCRYPTED:"+str(encrypted_message.hex())+"<"+str(len(encrypted_message))+">")
        for i in range(nb_elements):
            id = int.from_bytes(message[(i*4):(i*4)+2], byteorder='big')
            type = message[(i*4)+2]
            val = message[(i*4)+3]
            print("%d,%d,%d" % (id,type,val))
            json_val = {'id': id, 'type' : type , 'value' : val}
            mqtt_message="intensity,id=%s,type=%s values=%s" % (str(id),str(type),str(val))
            #publish(my_mqtt_client,mqtt_message)
            threading.Thread(target=send_json, args=(json_val,IP_HOST)).start()
    except Exception as e:
        print("Failed to read or store data in database "+str(e))
  

    #mqtt_message="intensity,row=%s,col=%s values=%s" % (str(message[0]),str(message[2]),str(message[4]))

    #publish(my_mqtt_client,mqtt_message)


    
