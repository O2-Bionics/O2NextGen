﻿using Microsoft.AspNetCore.SignalR;
using System;
using System.Threading.Tasks;

namespace O2NextGen.SmallTalk.SignalrHub.Hubs
{
    public interface IChatHub {
        Task UpdateMessages();
    }
    public class ChatHub : Hub, IChatHub
    {
        public async Task NewUserAsync(string username)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, username);
            await base.OnConnectedAsync();
        }

        public async Task UpdateMessages()
        {
            await Clients.All.SendAsync("OnUpdateMessage");
        }

        //public override async Task OnConnectedAsync()
        //{
        //    await Groups.AddToGroupAsync(Context.ConnectionId, Context.User.Identity.Name);
        //    await base.OnConnectedAsync();
        //}

        //public override async Task OnDisconnectedAsync(Exception ex)
        //{
        //    await Groups.RemoveFromGroupAsync(Context.ConnectionId, Context.User.Identity.Name);
        //    await base.OnDisconnectedAsync(ex);
        //}
    }
}
