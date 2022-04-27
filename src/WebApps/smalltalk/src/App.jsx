import axios from "axios";
import React, { useState, useEffect, useRef } from "react";
import ReactDOM from "react-dom";
import MessageItem from "./components/MessageItem";
import "./index.scss";
import * as signalR from '@microsoft/signalr';
import iconBookmarks from './assets/bookmarks_black_24dp.svg';
import iconSms from './assets/sms_black_24dp.svg';
import iconSettings from './assets/settings_black_24dp.svg';
import iconLogout from './assets/power_settings_new_black_24dp.svg';
import iconAccoutSettings from './assets/manage_accounts_black_24dp.svg';
import iconSearch from './assets//search_black_24dp.svg';
function App() {
  const [connection, setConnection] = useState(null);
  const messageRef = useRef();

  const [messages, setMessages] = useState([
    { id: 1, message: 'denis prokhorchik' },
    { id: 2, message: 'denis prokhorchik2' },
    { id: 3, message: 'denis prokhorchik2' }
  ])

  const [message, setMessage] = useState('')

  useEffect(() => {
    let connect = new signalR.HubConnectionBuilder()
      .withUrl("https://signalr.o2bus.com/chathub")
      .configureLogging(signalR.LogLevel.Information)
      .withAutomaticReconnect()
      .build();

    connect.on("OnUpdateMessage", async () => {
      console.log("get data")
      await fetchData()
      scrollDown();
    });
    connect.start().then(() => {
      connect.invoke("NewUserAsync", "Denis")
      console.log('Connection started!')
    })
      .catch(err => console.log(err));
    console.log("invoke is called")
    setConnection(connect)
  }, []);
  function scrollDown() {
    if (messageRef && messageRef.current) {
      const { scrollHeight, clientHeight } = messageRef.current;
      messageRef.current.scrollTo({
        left: 0, top: scrollHeight - clientHeight,
        behavior: "smooth"
      })
    }
  }
  async function sendMessage() {
    try {
      const newMessage = { id: 1, SenderId: 1, RecipientId: 2, Message: message };
      await axios.post("https://api-smalltalk.o2bus.com/api/chat/session/1/messages",
        newMessage
      )
      //fetchData();
    }
    catch (e) {
      console.log(e)
    }
  }
  async function fetchData() {
    const response =
      await axios.get('https://api-smalltalk.o2bus.com/api/chat/session/1/messages');
    console.log(response)
    setMessages(response.data)
  }

  return (
    <div className="flex">
      <div className="w-14 h-screen flex flex-col items-center justify-between">
        <div className="w-10 m-2">
          <img src="https://seeklogo.com/images/P/pypestream-logo-51F60D3389-seeklogo.com.png" alt="" />
        </div>

        <div className="flex flex-col">
          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconBookmarks} alt="bookmarks" />
            <div className="w-1 h-1 bg-blue-500 rounded-full">
            </div>
          </div>
          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconSms} alt="sms" />
            <div className="w-1 h-1 bg-blue-500 rounded-full">
            </div>
          </div>
          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconBookmarks} alt="bookmarks" />
            <div className="w-1 h-1 bg-blue-500 rounded-full">
            </div>
          </div>
          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconAccoutSettings} alt="account settings" />
            <div className="w-1 h-1 bg-blue-500 rounded-full">
            </div>
          </div>

          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconLogout} alt="logout" />
            <div className="w-1 h-1 bg-blue-500 rounded-full">
            </div>
          </div>
        </div>
        <div>
        </div>
        <div className="flex flex-col">
          <div className="py-3 w-5 flex flex-col justify-center items-center">
            <img src={iconSettings} alt="settings" />
          </div>
        </div>
      </div>
      <div className="w-60 h-screen bg-gray-100">
        <div className="text-xl p-3">
          Chats
        </div>
        <div className="p-3 flex">
          <input className="p-2 w-10/12 bg-gray-200" 
            type="text" placeholder="search for messages of users..." />
          <div className="w-2/12 flex justify-center items-center bg-gray-200">
            <img className="w-5" src={iconSearch} alt="search"/>
          </div>
        </div>
      </div>
      <div className="flex-grow h-screen bg-blue-100">
        <div ref={messageRef} className="overflow-y-auto h-3/4">
          {messages.map((item) =>
            <MessageItem message={item} key={item.id}></MessageItem>
          )}

        </div>

        <div className="flex h-1/4">
          <div className="flex flex-col">
            <form onSubmit={e => {
              sendMessage(message)

            }}>
              <input type="text" placeholder="text" value={message} onChange={(e) => {
                setMessage(e.target.value)
              }} />
              <button className="btn bg-blue-500 m-1 py-2 px-4" onClick={(e) => {
                e.preventDefault()
                sendMessage()
              }}>Send message</button>
            </form>
          </div>
          <div className="flex flex-col">
            <button className="btn bg-red-300 m-1 py-2 px-4" onClick={fetchData}> Get Messages</button>
          </div>
        </div>
      </div>
    </div>
  );
}
ReactDOM.render(<App />, document.getElementById("app"));
