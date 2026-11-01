class Insite < Formula
  desc "Full X-ray of a website from the terminal: network, TLS, DNS, stack, security, SEO and weight"
  homepage "https://github.com/jospnunes/insite"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jospnunes/insite/releases/download/v0.1.0/insite-aarch64-apple-darwin.tar.xz"
      sha256 "0bf60522e76bea22e0f60876cbed11877abff6ecae8c6484ae8e56f8d2afacd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jospnunes/insite/releases/download/v0.1.0/insite-x86_64-apple-darwin.tar.xz"
      sha256 "db80c5568af81ee72017f3aae542e85939c44c639d28720d8868a1884a2e9d00"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jospnunes/insite/releases/download/v0.1.0/insite-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "65b4f3e7f994ba3a00d0d9c98b2a5bf27cd4a5cc087461dcb2d4022c77459b79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jospnunes/insite/releases/download/v0.1.0/insite-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a15690a88d3cf8acb7a8b88607a1ddecbfcb600508558dd33bcd10281c4934e3"
    end
  end
  license "GPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "insite"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "insite"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "insite"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "insite"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
