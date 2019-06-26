require 'spec_helper_acceptance'

def run_function(name, param)
  pp = <<-PUPPETCODE
    $return = #{name}('#{param}')

    file { '/result':
      ensure  => file,
      content => String.new($return),
    }
  PUPPETCODE

  idempotent_apply(pp)
  file('/result')
end

describe 'testing supporting functions' do
  describe 'checking class existence' do
    context 'when a class exists' do
      it 'returns true' do
        result = run_function('safe_include::class_exists', 'postgresql::server')

        expect(result).to contain 'true'
      end
    end

    context 'when a class doesn\'t exist' do
      it 'returns false' do
        result = run_function('safe_include::class_exists', 'postgresql::alkdjncsjkdncksdubc')

        expect(result).to contain 'false'
      end
    end

    context 'when the class has a single segment' do
      it 'finds a single-name class' do
        result = run_function('safe_include::class_exists', 'apache')

        expect(result).to contain 'true'
      end

      it 'returns the correct path' do
        result = run_function('safe_include::class_location', 'apache')

        expect(result).to contain 'apache/manifests/init.pp'
      end
    end
  end

  describe 'checking class location' do
    context 'with a class' do
      it 'works' do
        result = run_function('safe_include::class_location', 'postgresql::server')

        expect(result).to contain '/etc/puppetlabs/code/environments/production/modules/postgresql/manifests/server.pp'
      end
    end
  end

  describe 'using safe_include' do
    context 'with a class' do
      it 'handles a single class' do
        apply_manifest(
          'safe_include("postgresql::server")',
          catch_failures: true,
        )

        expect(user('postgres')).to exist
      end

      it 'handles an array' do
        apply_manifest(
          'safe_include(["postgresql::server","postgresql::server"])',
          catch_failures: true,
        )

        expect(user('postgres')).to exist
      end

      it 'handles undef values' do
        apply_manifest(
          'safe_include(["postgresql::server",undef])',
          catch_failures: true,
        )

        expect(user('postgres')).to exist
      end
    end
  end
end
