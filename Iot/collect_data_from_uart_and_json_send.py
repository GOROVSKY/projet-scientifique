import serial
import time
from paho.mqtt import client as mqtt_client
import datetime
import requests
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
IP_HOST = "192.168.43.186"


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

time.sleep(3)

my_mqtt_client = connect_mqtt()
#my_mqtt_client.loop_start()
while 1:
    time.sleep(0.02)
    try:
        nb_elements_as_bytes = ser.read(1)
        nb_elements = int.from_bytes(nb_elements_as_bytes,'big')
        message = ser.read(4*nb_elements)
        print("NB:"+str(nb_elements))
        print("MSG:"+str(message))
        for i in range(nb_elements):
            id = int.from_bytes(message[(i*4):(i*4)+2], byteorder='big')
            type = message[(i*4)+2]
            val = message[(i*4)+3]
            print("%d,%d,%d" % (id,type,val))
            json_val = {'id': id, 'type' : type , 'value' : val}
            #req = requests.post('http://%s:8000/api/sensor_data' % (IP_HOST), json = json_val)
            #mqtt_message="intensity,id=%s,type=%s values=%s" % (str(id),str(type),str(val))
            #publish(my_mqtt_client,mqtt_message)
            # if req.status_code ==200:
            #     print("Data inserted into database sucessfully")
    except Exception as e:
        print("Failed to read or store data in database "+str(e))

    #mqtt_message="intensity,row=%s,col=%s values=%s" % (str(message[0]),str(message[2]),str(message[4]))

    #publish(my_mqtt_client,mqtt_message)


    
