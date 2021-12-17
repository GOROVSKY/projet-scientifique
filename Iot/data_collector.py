import psycopg2
import psycopg2.extras
import serial
import schedule
import time
import requests
import json
#ID,CODE,LATITUDE,LONGITUDE,ROW,COLUMN,INTENSITY,DATE

SERIALPORT = "/dev/ttyS5"
BAUDRATE = 115200
ser = serial.Serial()
IP_HOST = "192.168.0.28"
value_dict= dict()


def get_data_from_db_and_send_to_uart():
    global ser
    nb_try=0
    while nb_try<3:
        try:
            req = requests.get('http://%s:5000/api/sensors' % (IP_HOST))
            if req.status_code ==200:
                response = req.json()
                #print(response) 
                for row in response:         
                    sensor_id = int(row['id'])
                    msg_type = int(row['type_id'])
                    value = int(row['value'])
                    if sensor_id in value_dict:
                        value_dict[sensor_id][msg_type]=value
                    else:
                        value_dict[sensor_id]=dict()
                        value_dict[sensor_id][msg_type]=value
                    print("id=%d,type=%d,value=%d" % (sensor_id,msg_type,value))
                
                
                print("VALUE DICT")
                msg = b''
                nb_element_to_send=0
                for sensor_id in value_dict:
                    for msg_type in value_dict[sensor_id]:
                        value= value_dict[sensor_id][msg_type]
                        print("id=%d,type=%d,value=%d" % (sensor_id,msg_type,value_dict[sensor_id][msg_type]))
                        sensor_id_as_bytes = sensor_id.to_bytes(2,byteorder='big')
                        msg_type_as_bytes =  msg_type.to_bytes(1,byteorder='big') 
                        value_as_bytes = value.to_bytes(1,byteorder='big')
                        msg+= sensor_id_as_bytes+msg_type_as_bytes+value_as_bytes
                        nb_element_to_send+=1
                        if(nb_element_to_send==60):
                            nb_element_to_send_as_bytes =  nb_element_to_send.to_bytes(1,byteorder='big')
                            ser.write(nb_element_to_send_as_bytes+msg)
                            print("Message <" + str(nb_element_to_send_as_bytes+msg) + "> <"+str(len(msg))+"> sent to micro-controller." )
                            msg=b''
                            nb_element_to_send=0
                            time.sleep(0.05)

                if(nb_element_to_send>0):
                    nb_element_to_send_as_bytes =  nb_element_to_send.to_bytes(1,byteorder='big')
                    ser.write(nb_element_to_send_as_bytes+msg)
                    print("Message <" + str(nb_element_to_send_as_bytes+msg) + "> <"+str(len(msg))+"> sent to micro-controller." )
                    msg=b''
                    nb_element_to_send=0
                    time.sleep(0.05)
                
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
    

