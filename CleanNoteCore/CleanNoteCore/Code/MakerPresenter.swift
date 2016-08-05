public protocol MakerInterface {
  func didMake(note: Note)
}

public class MakerPresenter: MakerInteractorOutput {
  let interface: MakerInterface

  public init(interface: MakerInterface) {
    self.interface = interface
  }

  public func didMake(note: Note) {
    interface.didMake(note: note)
  }
}
