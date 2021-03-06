import React, { useState, useEffect, useRef } from "react";
import iconAvatar from '.././assets/avatar-1.jpeg';
import iconDenisAvatar from '.././assets/Denis_prox.jpg';

const MessageItem = (props) => {
    const [owner, setOwner] = useState(false)
    useEffect(() => {
        GetInfo();
    }, [])

    function GetInfo() {
        if (props.message.senderId == 1)
            setOwner(false)
        else setOwner(true)
    }
    return (
        <div>
            {owner ?
                <div className="flex justify-start">
                    <div className="flex items-end">
                        <div className="pl-2 pr-2">
                            <img className="w-8 h-8 rounded-full" src={iconDenisAvatar} alt="Denis" />
                            <div className="w-4 h-4 relative left-5 bottom-3 bg-white rounded-full"></div>
                            <div className="w-2 h-2 relative left-6 bottom-6 bg-red-500 rounded-full"></div>
                        </div>
                    </div>
                    <div className="m-2 bg-gray-100 p-3  flex-col rounded-tl-lg rounded-tr-lg rounded-br-lg">
                        {/* < p > sender: { props.message.senderId }</p >
                <p>recipient: {props.message.recipientId}</p> */}
                        <p className='text-sm'>Denis Prokharchyk (<strong>{props.message.recipientId}</strong>)</p>
                        <p className='text-xs text-gray-500'>
                            {props.message.message}
                        </p>
                        <p className='text-xs text-gray-400'>8 min ago</p>
                    </div >

                </div>
                :
                <div className="flex justify-end m-8">
                    <div className="bg-blue-500 p-3 items-end flex-col rounded-tl-lg rounded-tr-lg rounded-bl-lg ">
                        <p className='text-sm text-white'>me (<strong>{props.message.recipientId}</strong>)</p>
                        <p className='text-xs text-gray-100'>
                            {props.message.message}
                        </p>
                        <p className='text-xs text-gray-400'>8 min ago</p>
                    </div >
                    <div className="flex items-end">
                        <div className="pl-2 pr-2">
                            <img className="w-8 h-8 rounded-full" src={iconAvatar} alt="Denis" />
                            <div className="w-4 h-4 relative left-5 bottom-3 bg-white rounded-full"></div>
                            <div className="w-2 h-2 relative left-6 bottom-6 bg-green-500 rounded-full"></div>
                        </div>
                    </div>
                </div>
            }
        </div>

    )
}

export default MessageItem