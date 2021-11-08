actor {
  stable var running = false;

  public func launch(): async Text {
    running := true;
    return "The daemon process is running";
  };

  public func stop(): async Text {
    running := false;
    return "The daemon is stopped";
  };
};