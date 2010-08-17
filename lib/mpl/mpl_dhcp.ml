(* This file was autogenerated by MPL *)
module Dhcp = struct
  open Mpl_stdlib
  exception Bad_packet of string

  type op_t = [
    |`BootRequest
    |`BootReply
    |`Unknown of int
  ]

  let op_marshal (a:op_t) =
    match a with
    |`BootRequest -> 1
    |`BootReply -> 2
    |`Unknown x -> x

  let op_unmarshal a : op_t =
    match a with
    |1 -> `BootRequest
    |2 -> `BootReply
    |x -> `Unknown x

  let op_to_string (a:op_t) =
    match a with
    |`BootRequest -> "BootRequest"
    |`BootReply -> "BootReply"
    |`Unknown x -> Printf.sprintf "%d" x

  let op_of_string s : op_t option = match s with
    |"BootRequest" -> Some `BootRequest
    |"BootReply" -> Some `BootReply
    |_ -> None

  class o
    ~(options_length:int)
    (env:env) =
    object(self)
      method env = env_at env 0 self#sizeof
      method sizeof = options_length+4+128+64+16+4+4+4+4+1+1+2+4+1+1+1+1
      method op =
        let op = Mpl_byte.to_int (Mpl_byte.at env (0)) in
        op_unmarshal op
      method set_op v : unit =
        Mpl_byte.marshal (env_at env (0) 1) (Mpl_byte.of_int v)



      method hops =
        Mpl_byte.to_int (Mpl_byte.at env (1+1+1))
      method set_hops v : unit =
        Mpl_byte.marshal (env_at env (1+1+1) 1) (Mpl_byte.of_int v)

      method xid =
        Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1+1+1))
      method set_xid v : unit =
        Mpl_uint32.marshal (env_at env (1+1+1+1) 4) (Mpl_uint32.of_int32 v)

      method secs =
        Mpl_uint16.to_int (Mpl_uint16.at env (1+1+1+1+4))
      method set_secs v : unit =
        Mpl_uint16.marshal (env_at env (1+1+1+1+4) 2) (Mpl_uint16.of_int v)


      method broadcast =
        let __bitdummy0 = Mpl_byte.to_int (Mpl_byte.at env (1+1+1+1+4+2)) in
        ((__bitdummy0 lsr 7) lsl 0)
      (* set_broadcast unsupported for now (type bit) *)



      method ciaddr =
        Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1+1+1+4+2+1+1))
      method set_ciaddr v : unit =
        Mpl_uint32.marshal (env_at env (1+1+1+1+4+2+1+1) 4) (Mpl_uint32.of_int32 v)

      method yiaddr =
        Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1+1+1+4+2+1+1+4))
      method set_yiaddr v : unit =
        Mpl_uint32.marshal (env_at env (1+1+1+1+4+2+1+1+4) 4) (Mpl_uint32.of_int32 v)

      method siaddr =
        Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1+1+1+4+2+1+1+4+4))
      method set_siaddr v : unit =
        Mpl_uint32.marshal (env_at env (1+1+1+1+4+2+1+1+4+4) 4) (Mpl_uint32.of_int32 v)

      method giaddr =
        Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1+1+1+4+2+1+1+4+4+4))
      method set_giaddr v : unit =
        Mpl_uint32.marshal (env_at env (1+1+1+1+4+2+1+1+4+4+4) 4) (Mpl_uint32.of_int32 v)

      method chaddr =
        Mpl_raw.at env (1+1+1+1+4+2+1+1+4+4+4+4) 16
      (* set_chaddr unsupported for now (type byte array) *)
      method chaddr_env : env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4) 16
      method chaddr_frag = Mpl_raw.frag env (1+1+1+1+4+2+1+1+4+4+4+4) 16
      method chaddr_length = 16

      method sname =
        Mpl_raw.at env (1+1+1+1+4+2+1+1+4+4+4+4+16) 64
      (* set_sname unsupported for now (type byte array) *)
      method sname_env : env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16) 64
      method sname_frag = Mpl_raw.frag env (1+1+1+1+4+2+1+1+4+4+4+4+16) 64
      method sname_length = 64

      method file =
        Mpl_raw.at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64) 128
      (* set_file unsupported for now (type byte array) *)
      method file_env : env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64) 128
      method file_frag = Mpl_raw.frag env (1+1+1+1+4+2+1+1+4+4+4+4+16+64) 128
      method file_length = 128


      method options =
        Mpl_raw.at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64+128+4) options_length
      (* set_options unsupported for now (type byte array) *)
      method options_env : env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64+128+4) options_length
      method options_frag = Mpl_raw.frag env (1+1+1+1+4+2+1+1+4+4+4+4+16+64+128+4) options_length
      method options_length = options_length


      method prettyprint =
        let out = prerr_endline in
        out "[ Dhcp.dhcp ]";
        out ("  op = " ^ (op_to_string self#op));
        (* htype : bound *)
        (* hlen : bound *)
        out ("  hops = " ^ (Printf.sprintf "%u" self#hops));
        out ("  xid = " ^ (Printf.sprintf "%lu" self#xid));
        out ("  secs = " ^ (Printf.sprintf "%u" self#secs));
        (* __bitdummy0 : bound *)
        out ("  broadcast = " ^ (Printf.sprintf "%u" self#broadcast));
        (* __bitdummy1 : bound *)
        (* reserved : bound *)
        out ("  ciaddr = " ^ (Printf.sprintf "%lu" self#ciaddr));
        out ("  yiaddr = " ^ (Printf.sprintf "%lu" self#yiaddr));
        out ("  siaddr = " ^ (Printf.sprintf "%lu" self#siaddr));
        out ("  giaddr = " ^ (Printf.sprintf "%lu" self#giaddr));
        out ("  chaddr = " ^ (Mpl_raw.prettyprint self#chaddr));
        out ("  sname = " ^ (Mpl_raw.prettyprint self#sname));
        out ("  file = " ^ (Mpl_raw.prettyprint self#file));
        (* cookie : bound *)
        out ("  options = " ^ (Mpl_raw.prettyprint self#options));
        ()
    end

  let t
    ~op
    ?(hops=0)
    ~xid
    ~secs
    ~broadcast
    ~ciaddr
    ~yiaddr
    ~siaddr
    ~giaddr
    ~(chaddr:data)
    ~(sname:data)
    ~(file:data)
    ~(options:data)
    env =
      let ___env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4) 0 in
      let chaddr___len = match chaddr with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> fn ___env; curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16) 0 in
      let sname___len = match sname with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> fn ___env; curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64) 0 in
      let file___len = match file with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> fn ___env; curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      let ___env = env_at env (1+1+1+1+4+2+1+1+4+4+4+4+16+64+128+4) 0 in
      let options___len = match options with 
      |`Str x -> Mpl_raw.marshal ___env x; String.length x
      |`Sub fn -> fn ___env; curpos ___env
      |`None -> 0
      |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
      if broadcast < 0 || broadcast > 1 then raise (Bad_packet "out of range (0 < broadcast < 1)");
      let reserved = 0 in (* const bit *)
      let __bitdummy1 = Mpl_byte.of_int ((reserved land 255)) in
      let __bitdummy0 = Mpl_byte.of_int ((reserved lsr 8) + (broadcast lsl 7)) in
      let htype = (Mpl_byte.of_int 1) in (* const *)
      let hlen = (Mpl_byte.of_int 6) in (* const *)
      let cookie = (Mpl_uint32.of_int32 1669485411l) in (* const *)
      let __op = op_marshal op in
      let __op = (Mpl_byte.of_int __op) in
      let hops = (Mpl_byte.of_int hops) in
      let xid = (Mpl_uint32.of_int32 xid) in
      let secs = (Mpl_uint16.of_int secs) in
      let ciaddr = (Mpl_uint32.of_int32 ciaddr) in
      let yiaddr = (Mpl_uint32.of_int32 yiaddr) in
      let siaddr = (Mpl_uint32.of_int32 siaddr) in
      let giaddr = (Mpl_uint32.of_int32 giaddr) in
      let chaddr = chaddr in
      let sname = sname in
      let file = file in
      let options = options in
      Mpl_byte.marshal env __op;
      Mpl_byte.marshal env htype;
      Mpl_byte.marshal env hlen;
      Mpl_byte.marshal env hops;
      Mpl_uint32.marshal env xid;
      Mpl_uint16.marshal env secs;
      Mpl_byte.marshal env __bitdummy0;
      (* bit broadcast *)
      Mpl_byte.marshal env __bitdummy1;
      (* bit reserved *)
      Mpl_uint32.marshal env ciaddr;
      Mpl_uint32.marshal env yiaddr;
      Mpl_uint32.marshal env siaddr;
      Mpl_uint32.marshal env giaddr;
      skip env chaddr___len;
      skip env sname___len;
      skip env file___len;
      Mpl_uint32.marshal env cookie;
      skip env options___len;
      new o
      ~options_length:options___len
      env

  let m (x:(env->o)) env = x env
  let sizeof (x:o) = x#sizeof
  let prettyprint (x:o) = x#prettyprint
  let env (x:o) = x#env

  let unmarshal 
    (env:env) : o =
    skip env 1; (* skipped op *)
    skip env 1; (* skipped htype *)
    skip env 1; (* skipped hlen *)
    skip env 1; (* skipped hops *)
    skip env 4; (* skipped xid *)
    skip env 2; (* skipped secs *)
    skip env 1; (* skipped __bitdummy0 *)
    skip env 1; (* skipped __bitdummy1 *)
    skip env 4; (* skipped ciaddr *)
    skip env 4; (* skipped yiaddr *)
    skip env 4; (* skipped siaddr *)
    skip env 4; (* skipped giaddr *)
    skip env 16; (* skipped chaddr *)
    skip env 64; (* skipped sname *)
    skip env 128; (* skipped file *)
    skip env 4; (* skipped cookie *)
    let options_length = (remaining env) in
    skip env options_length; (* skipped options *)
    new o env
    ~options_length:options_length
end

module Dhcp_option = struct
  open Mpl_stdlib
  exception Bad_packet of string

  module End = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 1


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.End.dhcp_option ]";
          (* code : bound *)
          ()
      end

    let t
      env =
        let code = (Mpl_byte.of_int 255) in (* const *)
        Mpl_byte.marshal env code;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module MaxSize = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 2+1+1


        method size =
          Mpl_uint16.to_int (Mpl_uint16.at env (1+1))
        method set_size v : unit =
          Mpl_uint16.marshal (env_at env (1+1) 2) (Mpl_uint16.of_int v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.MaxSize.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  size = " ^ (Printf.sprintf "%u" self#size));
          ()
      end

    let t
      ~size
      env =
        let code = (Mpl_byte.of_int 57) in (* const *)
        let olen = (Mpl_byte.of_int 2) in (* const *)
        let size = (Mpl_uint16.of_int size) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint16.marshal env size;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module ClientID = struct
    class o
      ~(id_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = id_length+1+1+1


        method htype =
          Mpl_byte.to_int (Mpl_byte.at env (1+1))
        method set_htype v : unit =
          Mpl_byte.marshal (env_at env (1+1) 1) (Mpl_byte.of_int v)

        method id =
          Mpl_raw.at env (1+1+1) id_length
        (* set_id unsupported for now (type byte array) *)
        method id_env : env = env_at env (1+1+1) id_length
        method id_frag = Mpl_raw.frag env (1+1+1) id_length
        method id_length = id_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.ClientID.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  htype = " ^ (Printf.sprintf "%u" self#htype));
          out ("  id = " ^ (Mpl_raw.prettyprint self#id));
          ()
      end

    let t
      ~htype
      ~(id:data)
      env =
        let ___env = env_at env (1+1+1) 0 in
        let id___len = match id with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let id___sizeof = id___len in
        let code = (Mpl_byte.of_int 61) in (* const *)
        let olen = (Mpl_byte.of_int (id___sizeof + 1)) in (* bound *)
        let htype = (Mpl_byte.of_int htype) in
        let id = id in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_byte.marshal env htype;
        skip env id___len;
        new o
        ~id_length:id___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module ParameterRequest = struct
    class o
      ~(params_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = params_length+1+1


        method params =
          Mpl_raw.at env (1+1) params_length
        (* set_params unsupported for now (type byte array) *)
        method params_env : env = env_at env (1+1) params_length
        method params_frag = Mpl_raw.frag env (1+1) params_length
        method params_length = params_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.ParameterRequest.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  params = " ^ (Mpl_raw.prettyprint self#params));
          ()
      end

    let t
      ~(params:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let params___len = match params with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let params___sizeof = params___len in
        let code = (Mpl_byte.of_int 55) in (* const *)
        let olen = (Mpl_byte.of_int params___sizeof) in (* bound *)
        let params = params in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env params___len;
        new o
        ~params_length:params___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module ServerIdentifier = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 4+1+1


        method id =
          Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1))
        method set_id v : unit =
          Mpl_uint32.marshal (env_at env (1+1) 4) (Mpl_uint32.of_int32 v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.ServerIdentifier.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  id = " ^ (Printf.sprintf "%lu" self#id));
          ()
      end

    let t
      ~id
      env =
        let id___sizeof = 4 in
        let code = (Mpl_byte.of_int 54) in (* const *)
        let olen = (Mpl_byte.of_int 4) in (* const *)
        let id = (Mpl_uint32.of_int32 id) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint32.marshal env id;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module MessageType = struct
    type mtype_t = [
      |`Discover
      |`Offer
      |`Request
      |`Decline
      |`Ack
      |`Nak
      |`Release
      |`Inform
      |`Unknown of int
    ]

    let mtype_marshal (a:mtype_t) =
      match a with
      |`Discover -> 1
      |`Offer -> 2
      |`Request -> 3
      |`Decline -> 4
      |`Ack -> 5
      |`Nak -> 6
      |`Release -> 7
      |`Inform -> 8
      |`Unknown x -> x

    let mtype_unmarshal a : mtype_t =
      match a with
      |1 -> `Discover
      |2 -> `Offer
      |3 -> `Request
      |4 -> `Decline
      |5 -> `Ack
      |6 -> `Nak
      |7 -> `Release
      |8 -> `Inform
      |x -> `Unknown x

    let mtype_to_string (a:mtype_t) =
      match a with
      |`Discover -> "Discover"
      |`Offer -> "Offer"
      |`Request -> "Request"
      |`Decline -> "Decline"
      |`Ack -> "Ack"
      |`Nak -> "Nak"
      |`Release -> "Release"
      |`Inform -> "Inform"
      |`Unknown x -> Printf.sprintf "%d" x

    let mtype_of_string s : mtype_t option = match s with
      |"Discover" -> Some `Discover
      |"Offer" -> Some `Offer
      |"Request" -> Some `Request
      |"Decline" -> Some `Decline
      |"Ack" -> Some `Ack
      |"Nak" -> Some `Nak
      |"Release" -> Some `Release
      |"Inform" -> Some `Inform
      |_ -> None

    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 1+1+1


        method mtype =
          let mtype = Mpl_byte.to_int (Mpl_byte.at env (1+1)) in
          mtype_unmarshal mtype
        method set_mtype v : unit =
          Mpl_byte.marshal (env_at env (1+1) 1) (Mpl_byte.of_int v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.MessageType.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  mtype = " ^ (mtype_to_string self#mtype));
          ()
      end

    let t
      ~mtype
      env =
        let code = (Mpl_byte.of_int 53) in (* const *)
        let olen = (Mpl_byte.of_int 1) in (* const *)
        let __mtype = mtype_marshal mtype in
        let __mtype = (Mpl_byte.of_int __mtype) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_byte.marshal env __mtype;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module LeaseTime = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 4+1+1


        method time =
          Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1))
        method set_time v : unit =
          Mpl_uint32.marshal (env_at env (1+1) 4) (Mpl_uint32.of_int32 v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.LeaseTime.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  time = " ^ (Printf.sprintf "%lu" self#time));
          ()
      end

    let t
      ~time
      env =
        let code = (Mpl_byte.of_int 51) in (* const *)
        let olen = (Mpl_byte.of_int 4) in (* const *)
        let time = (Mpl_uint32.of_int32 time) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint32.marshal env time;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module RequestedIP = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 4+1+1


        method ip =
          Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1))
        method set_ip v : unit =
          Mpl_uint32.marshal (env_at env (1+1) 4) (Mpl_uint32.of_int32 v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.RequestedIP.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  ip = " ^ (Printf.sprintf "%lu" self#ip));
          ()
      end

    let t
      ~ip
      env =
        let code = (Mpl_byte.of_int 50) in (* const *)
        let olen = (Mpl_byte.of_int 4) in (* const *)
        let ip = (Mpl_uint32.of_int32 ip) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint32.marshal env ip;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module DomainName = struct
    class o
      ~(name_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = name_length+1+1


        method name =
          Mpl_raw.at env (1+1) name_length
        (* set_name unsupported for now (type byte array) *)
        method name_env : env = env_at env (1+1) name_length
        method name_frag = Mpl_raw.frag env (1+1) name_length
        method name_length = name_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.DomainName.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  name = " ^ (Mpl_raw.prettyprint self#name));
          ()
      end

    let t
      ~(name:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let name___len = match name with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let name___sizeof = name___len in
        let code = (Mpl_byte.of_int 15) in (* const *)
        let olen = (Mpl_byte.of_int name___sizeof) in (* bound *)
        let name = name in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env name___len;
        new o
        ~name_length:name___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module HostName = struct
    class o
      ~(hostname_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = hostname_length+1+1


        method hostname =
          Mpl_raw.at env (1+1) hostname_length
        (* set_hostname unsupported for now (type byte array) *)
        method hostname_env : env = env_at env (1+1) hostname_length
        method hostname_frag = Mpl_raw.frag env (1+1) hostname_length
        method hostname_length = hostname_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.HostName.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  hostname = " ^ (Mpl_raw.prettyprint self#hostname));
          ()
      end

    let t
      ~(hostname:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let hostname___len = match hostname with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let hostname___sizeof = hostname___len in
        let code = (Mpl_byte.of_int 12) in (* const *)
        let olen = (Mpl_byte.of_int hostname___sizeof) in (* bound *)
        let hostname = hostname in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env hostname___len;
        new o
        ~hostname_length:hostname___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module DNSServer = struct
    class o
      ~(nameserver_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = nameserver_length+1+1


        method nameserver =
          Mpl_raw.at env (1+1) nameserver_length
        (* set_nameserver unsupported for now (type byte array) *)
        method nameserver_env : env = env_at env (1+1) nameserver_length
        method nameserver_frag = Mpl_raw.frag env (1+1) nameserver_length
        method nameserver_length = nameserver_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.DNSServer.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  nameserver = " ^ (Mpl_raw.prettyprint self#nameserver));
          ()
      end

    let t
      ~(nameserver:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let nameserver___len = match nameserver with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let nameserver___sizeof = nameserver___len in
        let code = (Mpl_byte.of_int 6) in (* const *)
        let olen = (Mpl_byte.of_int nameserver___sizeof) in (* bound *)
        let nameserver = nameserver in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env nameserver___len;
        new o
        ~nameserver_length:nameserver___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module NameServer = struct
    class o
      ~(nameserver_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = nameserver_length+1+1


        method nameserver =
          Mpl_raw.at env (1+1) nameserver_length
        (* set_nameserver unsupported for now (type byte array) *)
        method nameserver_env : env = env_at env (1+1) nameserver_length
        method nameserver_frag = Mpl_raw.frag env (1+1) nameserver_length
        method nameserver_length = nameserver_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.NameServer.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  nameserver = " ^ (Mpl_raw.prettyprint self#nameserver));
          ()
      end

    let t
      ~(nameserver:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let nameserver___len = match nameserver with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let nameserver___sizeof = nameserver___len in
        let code = (Mpl_byte.of_int 5) in (* const *)
        let olen = (Mpl_byte.of_int nameserver___sizeof) in (* bound *)
        let nameserver = nameserver in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env nameserver___len;
        new o
        ~nameserver_length:nameserver___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module TimeServer = struct
    class o
      ~(timeserver_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = timeserver_length+1+1


        method timeserver =
          Mpl_raw.at env (1+1) timeserver_length
        (* set_timeserver unsupported for now (type byte array) *)
        method timeserver_env : env = env_at env (1+1) timeserver_length
        method timeserver_frag = Mpl_raw.frag env (1+1) timeserver_length
        method timeserver_length = timeserver_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.TimeServer.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  timeserver = " ^ (Mpl_raw.prettyprint self#timeserver));
          ()
      end

    let t
      ~(timeserver:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let timeserver___len = match timeserver with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let timeserver___sizeof = timeserver___len in
        let code = (Mpl_byte.of_int 4) in (* const *)
        let olen = (Mpl_byte.of_int timeserver___sizeof) in (* bound *)
        let timeserver = timeserver in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env timeserver___len;
        new o
        ~timeserver_length:timeserver___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module Router = struct
    class o
      ~(routers_length:int)
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = routers_length+1+1


        method routers =
          Mpl_raw.at env (1+1) routers_length
        (* set_routers unsupported for now (type byte array) *)
        method routers_env : env = env_at env (1+1) routers_length
        method routers_frag = Mpl_raw.frag env (1+1) routers_length
        method routers_length = routers_length


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.Router.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  routers = " ^ (Mpl_raw.prettyprint self#routers));
          ()
      end

    let t
      ~(routers:data)
      env =
        let ___env = env_at env (1+1) 0 in
        let routers___len = match routers with 
        |`Str x -> Mpl_raw.marshal ___env x; String.length x
        |`Sub fn -> fn ___env; curpos ___env
        |`None -> 0
        |`Frag t -> Mpl_raw.blit ___env t; curpos ___env in
        let routers___sizeof = routers___len in
        let code = (Mpl_byte.of_int 3) in (* const *)
        let olen = (Mpl_byte.of_int routers___sizeof) in (* bound *)
        let routers = routers in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        skip env routers___len;
        new o
        ~routers_length:routers___len
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module TimeOffset = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 4+1+1


        method offset =
          Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1))
        method set_offset v : unit =
          Mpl_uint32.marshal (env_at env (1+1) 4) (Mpl_uint32.of_int32 v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.TimeOffset.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  offset = " ^ (Printf.sprintf "%lu" self#offset));
          ()
      end

    let t
      ~offset
      env =
        let code = (Mpl_byte.of_int 2) in (* const *)
        let olen = (Mpl_byte.of_int 4) in (* const *)
        let offset = (Mpl_uint32.of_int32 offset) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint32.marshal env offset;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module SubnetMask = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 4+1+1


        method mask =
          Mpl_uint32.to_int32 (Mpl_uint32.at env (1+1))
        method set_mask v : unit =
          Mpl_uint32.marshal (env_at env (1+1) 4) (Mpl_uint32.of_int32 v)


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.SubnetMask.dhcp_option ]";
          (* code : bound *)
          (* olen : bound *)
          out ("  mask = " ^ (Printf.sprintf "%lu" self#mask));
          ()
      end

    let t
      ~mask
      env =
        let code = (Mpl_byte.of_int 1) in (* const *)
        let olen = (Mpl_byte.of_int 4) in (* const *)
        let mask = (Mpl_uint32.of_int32 mask) in
        Mpl_byte.marshal env code;
        Mpl_byte.marshal env olen;
        Mpl_uint32.marshal env mask;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  module Pad = struct
    class o
      (env:env) =
      object(self)
        method env = env_at env 0 self#sizeof
        method sizeof = 1


        method prettyprint =
          let out = prerr_endline in
          out "[ Dhcp_option.Pad.dhcp_option ]";
          (* code : bound *)
          ()
      end

    let t
      env =
        let code = (Mpl_byte.of_int 0) in (* const *)
        Mpl_byte.marshal env code;
        new o
        env

    let m (x:(env->o)) env = x env
    let sizeof (x:o) = x#sizeof
    let prettyprint (x:o) = x#prettyprint
    let env (x:o) = x#env
  end

  type o = [
  |`Pad of Pad.o
  |`SubnetMask of SubnetMask.o
  |`TimeOffset of TimeOffset.o
  |`Router of Router.o
  |`TimeServer of TimeServer.o
  |`NameServer of NameServer.o
  |`DNSServer of DNSServer.o
  |`HostName of HostName.o
  |`DomainName of DomainName.o
  |`RequestedIP of RequestedIP.o
  |`LeaseTime of LeaseTime.o
  |`MessageType of MessageType.o
  |`ServerIdentifier of ServerIdentifier.o
  |`ParameterRequest of ParameterRequest.o
  |`ClientID of ClientID.o
  |`MaxSize of MaxSize.o
  |`End of End.o
  ]

  type x = [
  |`Pad of (env -> Pad.o)
  |`SubnetMask of (env -> SubnetMask.o)
  |`TimeOffset of (env -> TimeOffset.o)
  |`Router of (env -> Router.o)
  |`TimeServer of (env -> TimeServer.o)
  |`NameServer of (env -> NameServer.o)
  |`DNSServer of (env -> DNSServer.o)
  |`HostName of (env -> HostName.o)
  |`DomainName of (env -> DomainName.o)
  |`RequestedIP of (env -> RequestedIP.o)
  |`LeaseTime of (env -> LeaseTime.o)
  |`MessageType of (env -> MessageType.o)
  |`ServerIdentifier of (env -> ServerIdentifier.o)
  |`ParameterRequest of (env -> ParameterRequest.o)
  |`ClientID of (env -> ClientID.o)
  |`MaxSize of (env -> MaxSize.o)
  |`End of (env -> End.o)
  ]

  let m (x:x) env : o = match x with
  |`Pad (fn:(env->Pad.o)) -> `Pad (fn env)
  |`SubnetMask (fn:(env->SubnetMask.o)) -> `SubnetMask (fn env)
  |`TimeOffset (fn:(env->TimeOffset.o)) -> `TimeOffset (fn env)
  |`Router (fn:(env->Router.o)) -> `Router (fn env)
  |`TimeServer (fn:(env->TimeServer.o)) -> `TimeServer (fn env)
  |`NameServer (fn:(env->NameServer.o)) -> `NameServer (fn env)
  |`DNSServer (fn:(env->DNSServer.o)) -> `DNSServer (fn env)
  |`HostName (fn:(env->HostName.o)) -> `HostName (fn env)
  |`DomainName (fn:(env->DomainName.o)) -> `DomainName (fn env)
  |`RequestedIP (fn:(env->RequestedIP.o)) -> `RequestedIP (fn env)
  |`LeaseTime (fn:(env->LeaseTime.o)) -> `LeaseTime (fn env)
  |`MessageType (fn:(env->MessageType.o)) -> `MessageType (fn env)
  |`ServerIdentifier (fn:(env->ServerIdentifier.o)) -> `ServerIdentifier (fn env)
  |`ParameterRequest (fn:(env->ParameterRequest.o)) -> `ParameterRequest (fn env)
  |`ClientID (fn:(env->ClientID.o)) -> `ClientID (fn env)
  |`MaxSize (fn:(env->MaxSize.o)) -> `MaxSize (fn env)
  |`End (fn:(env->End.o)) -> `End (fn env)

  let prettyprint (x:o) = match x with
  |`Pad x -> x#prettyprint
  |`SubnetMask x -> x#prettyprint
  |`TimeOffset x -> x#prettyprint
  |`Router x -> x#prettyprint
  |`TimeServer x -> x#prettyprint
  |`NameServer x -> x#prettyprint
  |`DNSServer x -> x#prettyprint
  |`HostName x -> x#prettyprint
  |`DomainName x -> x#prettyprint
  |`RequestedIP x -> x#prettyprint
  |`LeaseTime x -> x#prettyprint
  |`MessageType x -> x#prettyprint
  |`ServerIdentifier x -> x#prettyprint
  |`ParameterRequest x -> x#prettyprint
  |`ClientID x -> x#prettyprint
  |`MaxSize x -> x#prettyprint
  |`End x -> x#prettyprint

  let sizeof (x:o) = match x with
  |`Pad x -> x#sizeof
  |`SubnetMask x -> x#sizeof
  |`TimeOffset x -> x#sizeof
  |`Router x -> x#sizeof
  |`TimeServer x -> x#sizeof
  |`NameServer x -> x#sizeof
  |`DNSServer x -> x#sizeof
  |`HostName x -> x#sizeof
  |`DomainName x -> x#sizeof
  |`RequestedIP x -> x#sizeof
  |`LeaseTime x -> x#sizeof
  |`MessageType x -> x#sizeof
  |`ServerIdentifier x -> x#sizeof
  |`ParameterRequest x -> x#sizeof
  |`ClientID x -> x#sizeof
  |`MaxSize x -> x#sizeof
  |`End x -> x#sizeof

  let env (x:o) = match x with
  |`Pad x -> x#env
  |`SubnetMask x -> x#env
  |`TimeOffset x -> x#env
  |`Router x -> x#env
  |`TimeServer x -> x#env
  |`NameServer x -> x#env
  |`DNSServer x -> x#env
  |`HostName x -> x#env
  |`DomainName x -> x#env
  |`RequestedIP x -> x#env
  |`LeaseTime x -> x#env
  |`MessageType x -> x#env
  |`ServerIdentifier x -> x#env
  |`ParameterRequest x -> x#env
  |`ClientID x -> x#env
  |`MaxSize x -> x#env
  |`End x -> x#env


  let unmarshal 
    (env:env) : o =
    let code = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
    match code with
    |255 -> `End (
      new End.o env
    )
    |57 -> `MaxSize (
      skip env 1; (* skipped olen *)
      skip env 2; (* skipped size *)
      new MaxSize.o env
    )
    |61 -> `ClientID (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      skip env 1; (* skipped htype *)
      let id_length = (olen - 1) in
      skip env id_length; (* skipped id *)
      new ClientID.o env
      ~id_length:id_length
    )
    |55 -> `ParameterRequest (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let params_length = olen in
      skip env params_length; (* skipped params *)
      new ParameterRequest.o env
      ~params_length:params_length
    )
    |54 -> `ServerIdentifier (
      skip env 1; (* skipped olen *)
      skip env 4; (* skipped id *)
      new ServerIdentifier.o env
    )
    |53 -> `MessageType (
      skip env 1; (* skipped olen *)
      skip env 1; (* skipped mtype *)
      new MessageType.o env
    )
    |51 -> `LeaseTime (
      skip env 1; (* skipped olen *)
      skip env 4; (* skipped time *)
      new LeaseTime.o env
    )
    |50 -> `RequestedIP (
      skip env 1; (* skipped olen *)
      skip env 4; (* skipped ip *)
      new RequestedIP.o env
    )
    |15 -> `DomainName (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let name_length = olen in
      skip env name_length; (* skipped name *)
      new DomainName.o env
      ~name_length:name_length
    )
    |12 -> `HostName (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let hostname_length = olen in
      skip env hostname_length; (* skipped hostname *)
      new HostName.o env
      ~hostname_length:hostname_length
    )
    |6 -> `DNSServer (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let nameserver_length = olen in
      skip env nameserver_length; (* skipped nameserver *)
      new DNSServer.o env
      ~nameserver_length:nameserver_length
    )
    |5 -> `NameServer (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let nameserver_length = olen in
      skip env nameserver_length; (* skipped nameserver *)
      new NameServer.o env
      ~nameserver_length:nameserver_length
    )
    |4 -> `TimeServer (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let timeserver_length = olen in
      skip env timeserver_length; (* skipped timeserver *)
      new TimeServer.o env
      ~timeserver_length:timeserver_length
    )
    |3 -> `Router (
      let olen = Mpl_byte.to_int (Mpl_byte.unmarshal env) in
      let routers_length = olen in
      skip env routers_length; (* skipped routers *)
      new Router.o env
      ~routers_length:routers_length
    )
    |2 -> `TimeOffset (
      skip env 1; (* skipped olen *)
      skip env 4; (* skipped offset *)
      new TimeOffset.o env
    )
    |1 -> `SubnetMask (
      skip env 1; (* skipped olen *)
      skip env 4; (* skipped mask *)
      new SubnetMask.o env
    )
    |0 -> `Pad (
      new Pad.o env
    )
    |x -> raise (Bad_packet (Printf.sprintf ": %d" x))
end

