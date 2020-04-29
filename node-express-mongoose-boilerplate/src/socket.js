import createSocket from 'socket.io';
import sockets from 'sockets';

export default server => {
  const io = createSocket(server);
  io.on('connection', socket => {
    socket.on('sendMessage', sockets.sendMessage);
  });
  return io;
};
