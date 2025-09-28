tolk 1.1

struct Device {
    model: string;
    registeredAt: uint32;
}

struct Storage {
    devices: map<address, Device>;
    description: string;
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun registerDevice(model: string) {
    var st = Storage.load();
    let caller = get_caller();

    st.devices.set(caller, Device{model: model, registeredAt: blockchain.now()});
    st.description = "IoT auth registry storing devices per user in a map, storage grows indefinitely.";
    st.save();
}
