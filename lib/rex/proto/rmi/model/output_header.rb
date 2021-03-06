# -*- coding: binary -*-

module Rex
  module Proto
    module Rmi
      module Model
        # This class provides a representation of an RMI output stream header
        class OutputHeader < Element

          # @!attribute signature
          #   @return [String] the Java RMI header signature
          attr_accessor :signature
          # @!attribute version
          #   @return [Fixnum] the Java RMI version
          attr_accessor :version
          # @!attribute protocol
          #   @return [Fixnum] the protocol where the the messages are wrapped within
          attr_accessor :protocol

          private

          # Reads the signature from the IO
          #
          # @param io [IO] the IO to read from
          # @return [String]
          # @raise [RuntimeError] if fails to decode signature
          def decode_signature(io)
            signature = read_string(io, 4)
            unless signature == SIGNATURE
              raise ::RuntimeError, 'Failed to decode OutputHeader signature'
            end

            signature
          end

          # Reads the version from the IO
          #
          # @param io [IO] the IO to read from
          # @return [Fixnum]
          def decode_version(io)
            version = read_short(io)

            version
          end

          # Reads the protocol from the IO
          #
          # @param io [IO] the IO to read from
          # @return [Fixnum]
          # @raise [RuntimeError] if fails to decode the protocol
          def decode_protocol(io)
            valid_protocols = [STREAM_PROTOCOL, SINGLE_OP_PROTOCOL, MULTIPLEX_PROTOCOL]
            protocol = read_byte(io)

            unless valid_protocols.include?(protocol)
              raise ::RuntimeError, 'Failed to decode OutputHeader protocol'
            end

            protocol
          end

          # Encodes the signature field
          #
          # @return [String]
          def encode_signature
            signature
          end

          # Encodes the version field
          #
          # @return [String]
          def encode_version
            [version].pack('n')
          end

          # Encodes the protocol field
          #
          # @return [String]
          def encode_protocol
            [protocol].pack('C')
          end
        end
      end
    end
  end
end